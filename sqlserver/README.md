# SQL Server

A quick one-off SQL Server to test Azure [Hybrid Connections](https://docs.microsoft.com/en-us/azure/biztalk-services/integration-hybrid-connection-overview) from Azure App Service.

## Infrastructure

Using `az` CLI

```sh
location="West US 2"
group="SQLServer"
vmname="SQLServer"
image="MicrosoftSQLServer:SQL2016SP1-WS2016:SQLDEV:latest"
ADMINUSER="akazureuser"
ADMINPASS="changeme"

az group create --location "$location" --name $group

az vm create --resource-group $group --name $vmname \
    --image $image --admin-username $ADMINUSER --admin-password $ADMINPASS \
    --size Standard_A1_v2 --storage-sku Standard_LRS --authentication-type password
```

## SQL Server installation methods 

### Via official image

Microsoft provides Azure images with SQL Server 2016 Developer Edition (and many others) pre-installed.
This is the easiest way to get SQL Server, and what we use above.

To view available official SQL Server images: `az vm image list --publisher MicrosoftSQLServer -o table --all`

### Via running the installer

Documenting this approach in case it comes in handy later.
We don't yet deal with accessing installers from an external place like Azure Storage.
[Get a version of SQL Server 2016 here](https://www.microsoft.com/en-us/evalcenter/evaluate-sql-server-2016), for now the easiest is downloading directly in the new VM.

Here is a working example that automates the SQL Server installer from Powershell.

```ps1
MSSQL2016.exe `
/Quiet="True" /IAcceptSQLServerLicenseTerms="True" /Action="Install" `
/AGTSVCSTARTUPTYPE=Automatic /InstanceName="MSSQLSERVER" /Features="SQLENGINE" `
/SqlSysAdminAccounts="<domain>\<user>"
```

## Connecting to SQL Servers

TODO: the Azure image boots without the RDP port specififed in the NSG. I allowed `TCP port 3389` manually in the Console.  Automate this?

After RDPing to the Azure VM, open Powershell and list the current databases in the server:
```ps1
sqlcmd
1> EXEC sp_databases;
2> go
```

SSMS will work locally on the SQLServer VM, but you won't be able to connect directly from other machines using SSMS on port `1433`.  This is intentional as it more closely models the eventual AK setup.

VSCode is a nice interface for local connections

1. Install the `mssql` extension  
2. find "MS SQL: Connect" in your command palate
3. Connect to `localhost`, where Docker is running
4. Switch to the SQL file and cmd-palate to "MS SQL: Connect"
5. then "MS SQL: Execute Query".

## Local SQL Server notes

We need to verify that this example asp.net app can connect to the local db first.  We'll use Docker.

```sh
docker pull microsoft/mssql-server-linux
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=BaldEagle123' -p 1433:1433 -d microsoft/mssql-server-linux
docker ps -a
```

Debug problems with: `docker logs <container_id>`. I had to increase my Docker memory to 4G from my Mac menubar.

Run `sqlcmd` from inside the container:

```sh
docker exec -it <container_id> bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'BaldEagle123'
```

## Seeding with data

Create a new database and seed it with some data.
Run the contents of `seed.sql` on the new SQL Server via SSMS or VSCode or sqlcmd.
You should be able to issue this query and see some data:

```sql
USE AKTestDataBase
SELECT * FROM Employees
go
```

## Enabling Hybrid Connection

Hybrid Connections require at least a "Standard" App Service plan.
The `az` client does not yet support setting up hybrid connections.  ARM or Terrafrom must be used to fully automate this solution.

For now we just enable the Hybrid Connection from the Azure portal.  `App Service -> Networking -> Hybrid Connections`

```
Endpoint Name: SQLServerHybridConn (This is the name of the new HC resource)
Endpoint Host: SQLServer (This is the host where our external resource lives*)
Endpoint Port: 1433

Servicebus namespace: Create new
Location: Us West 2
Name: SQLServerServiceBus
```

**\*Note**: The "Endpoint Host" is confusing. It is the hostname as seen from the machine where the HCM is installed. We'll install the HCM on our SQL Server VM.  "localhost" is reserved, so get the correct hostname on the VM with Powershell: `hostname`.

### Install Hybrid Connection Manager

This client is installed on the machine that the AppService app is accessing. In our case, some external SQL Server.
On the Hybrid Connections screen there is a "Download connection manager" link. Use it.

Launch the "Hybrid Connection Manager UI" program and "Configure new Hybrid Connection". The program will ask for your Azure login and walk you through setup.

### Deployment for testing

I'm deploying to a short-lived AzureApps resource. I created it and deploy to it as described in `/appservice` folder.
I reset the "Deployment branch" under "Deployment options" in the portal to use my feature branch (this will come in handy for staging environment):  `git push azure <feature>`

### Hybrid/SQL Connection Strings

SQL Auth is supported, and is what we use. For now, I manually added a new SQL Server user using SSMS.

You can test your connection string locally on the "remote" SQL Server in powershell.

```ps1
$connstr = "Server=SQLServer,1433;Database=AKTestDataBase;User ID=sa;Password=<changeme>"
$sqlconn = New-Object System.Data.SqlClient.SqlConnection($connstr) 
$sqlconn.Open();
$sqlconn.Close();
```
**\*Note**: the `User ID` and `Password` below are SQL Server Auth credentails that you'll have to set up. 

**Further, the connection string is _identical_ for local/VM and Hybrid/PaaS connections.** This is the magic of Hybrid Connections.

### Hybrid Connection underlying technology

Please see the following pages for further documentation from Microsoft.

 [Azure Relay Documentation](https://docs.microsoft.com/en-us/azure/service-bus-relay/relay-what-is-it)
> In the relayed data transfer pattern, an on-premises service connects to the relay service through an outbound port and creates a bi-directional socket for communication tied to a particular rendezvous address. The client can then communicate with the on-premises service by sending traffic to the relay service targeting the rendezvous address. The relay service then "relays" data to the on-premises service through a bi-directional socket dedicated to each client. The client does not need a direct connection to the on-premises service, it is not required to know where the service resides, and the on-premises service does not need any inbound ports open on the firewall.

[Hybrid Protocol Documentation](https://docs.microsoft.com/en-us/azure/service-bus-relay/relay-hybrid-connections-protocol)
> The key capability elements provided by Relay are bi-directional, unbuffered communication across network boundaries with TCP-like throttling, endpoint discovery, connectivity status, and overlaid endpoint security. The relay capabilities differ from network-level integration technologies such as VPN, in that relay can be scoped to a single application endpoint on a single machine, while VPN technology is far more intrusive as it relies on altering the network environment.

[AppService Hybrid Connection Documentation](https://docs.microsoft.com/en-us/azure/app-service/app-service-hybrid-connections)
> The connection uses TLS 1.2 for security and SAS keys for authentication/authorization.


