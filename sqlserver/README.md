# SQL Server

A quick one-off SQL Server to test Azure [Hybrid Connections](https://docs.microsoft.com/en-us/azure/biztalk-services/integration-hybrid-connection-overview) from Azure App Service.

Also see the `/hybrid-connection` folder here.

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

Debug problems with: `docker logs <container_id>`.
**I had to increase my Docker memory to 4G from my Mac menubar.**

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




