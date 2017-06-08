# Azure Hybrid Connections

We use an Azure Hybrid Connection to connect to an on-prem SQL Server from within the Azure AppService.

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

> The key capability elements provided by Relay are bi-directional, unbuffered communication across network boundaries with TCP-like throttling, endpoint discovery, connectivity status, and overlaid endpoint security. The relay capabilities differ from network-level integration technologies such as VPN, in that relay can be scoped to a single application endpoint on a single machine, while VPN technology is far more intrusive as it relies on altering the network environment.

[AppService Hybrid Connection Documentation](https://docs.microsoft.com/en-us/azure/app-service/app-service-hybrid-connections)
> The connection uses TLS 1.2 for security and SAS keys for authentication/authorization.

[Hybrid Protocol Documentation](https://docs.microsoft.com/en-us/azure/service-bus-relay/relay-hybrid-connections-protocol)