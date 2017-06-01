# SQL Server

A quick one-off SQL Server to test Azure [Hybrid Connections](https://docs.microsoft.com/en-us/azure/biztalk-services/integration-hybrid-connection-overview) from Azure App Service.

## Create infra

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

## SQL Server installation notes 

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

## Connecting to SQL Server

TODO: this image boots without the RDP port specififed in the NSG. I allowed `TCP port 3389` manually in the Console.  Automate this?

After RDPing to the VM, open Powershell and list the current databases in the server:
```ps1
sqlcmd
1> EXEC sp_databases;
2> go
```

SSMS will work locally on the SQLServer VM, but you won't be able to connect directly from other machines using SSMS on port `1433`.  This is intentional as it more closely models the eventual AK setup.

## Seeding with data

Create a new database and seed it with some data.
Run the contents of `seed.sql` on the new SQL Server, SSMS is probably the easiest.
You should be able to issue this query and see some data:

```sql
USE AKTestDataBase
SELECT * FROM Employees
go
```

## Enabling Hybrid Connection

Hybrid Connections require at least a "Standard" App Service plan.
The `az` client does not yet support setting up hybrid connections.  ARM or Terrafrom must be used to fully automate this solution.

For now we just enable the Hybrid Connection from the Azure portal.

Endpoint Name: SQLServerHybridConn (This is the name of the new HC resource)
Endpoint Host: SQLServer (This is the host where our external resource lives)
Endpoint Port: 1433

Servicebus namespace: Create new
Location: Us West 2
Name: SQLServerServiceBus

**Note**: The "Endpoint Host" is confusing. It is the hostname as seen from the machine where the HCM is installed. We're installing the HCM on our SQL Server VM.  "localhost" is reserved, so get the correct hostname from Powershell with `hostname`.

### Install Hybrid Connection Manager

This client is installed on the machine that the AppService app is accessing. In our case, some external SQL Server.
On the external machine, download the HCM from the Azure portal.  On the Hybrid connections screen there is a "Download connection manager" link.

Launch the "Hybrid Connection Manager UI" program and "Configure new Hybrid Connection".

