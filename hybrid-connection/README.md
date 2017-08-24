# Azure Hybrid Connections

We use an Azure Hybrid Connection to connect to an on-prem SQL Server from within the Azure AppService PaaS.

## Enabling Hybrid Connection

Hybrid Connections require at least a "Standard" App Service plan.
The `az` client does not yet support setting up hybrid connections.  ARM or Terraform must be used to fully automate this solution.

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

SQL Auth is what we use for now. I manually added a new SQL Server user using SSMS.
In the future we will investigate other authentication options.

You can test your connection string locally on the "remote" SQL Server in powershell.

```ps1
$connstr = "Server=SQLServer,1433;Database=AKTestDataBase;User ID=<changeme>;Password=<changeme>"
$sqlconn = New-Object System.Data.SqlClient.SqlConnection($connstr) 
$sqlconn.Open();
$sqlconn.Close();
```
**\*Note**: the `User ID` and `Password` just above are SQL Server Auth credentials that you'll have to set up.

**Further, the connection string is _identical_ for local/VM and Hybrid/PaaS connections.** This is the magic of Hybrid Connections.

### Hybrid Connection underlying technology

Please see the following pages for further documentation from Microsoft.

 [Azure Relay Documentation](https://docs.microsoft.com/en-us/azure/service-bus-relay/relay-what-is-it)
> In the relayed data transfer pattern, an on-premises service connects to the relay service through an outbound port and creates a bi-directional socket for communication tied to a particular rendezvous address. The client can then communicate with the on-premises service by sending traffic to the relay service targeting the rendezvous address. The relay service then "relays" data to the on-premises service through a bi-directional socket dedicated to each client. The client does not need a direct connection to the on-premises service, it is not required to know where the service resides, and the on-premises service does not need any inbound ports open on the firewall.

> The key capability elements provided by Relay are bi-directional, unbuffered communication across network boundaries with TCP-like throttling, endpoint discovery, connectivity status, and overlaid endpoint security. The relay capabilities differ from network-level integration technologies such as VPN, in that relay can be scoped to a single application endpoint on a single machine, while VPN technology is far more intrusive as it relies on altering the network environment.

[AppService Hybrid Connection Documentation](https://docs.microsoft.com/en-us/azure/app-service/app-service-hybrid-connections)
> The connection uses TLS 1.2 for security and SAS keys for authentication/authorization.

[Hybrid Protocol Documentation](https://docs.microsoft.com/en-us/azure/service-bus-relay/relay-hybrid-connections-protocol)


## Whitelists

If our on-prem service lives in an environment where we must whitelist outbound connections, then we must whitelist various Azure/Hybrid things.

Ref:
- https://docs.microsoft.com/en-us/azure/service-bus-relay/relay-hybrid-connections-protocol
- https://blogs.msdn.microsoft.com/waws/2017/06/30/things-you-should-know-web-apps-and-hybrid-connections/#WhiteList


### Hybrid

Machine w/ HCM must whitelist **all of**:

1. "Service Bus endpoint URL" : find this value in the HCM details screen labeled as "Service Bus Endpoint" (`sqlserverservicebus.servicebus.windows.net` for our demo)

2. "Service Bus Gateways" : these are 128 different servers.  See discussion at "things you should know" link above.  128 different whitelists will have to be added for `G0-prod-[stamp]-010-sb.servicebus.windows.net` -> `G127-prod-[stamp]-010-sb.servicebus.windows.net`. (Hopefully we can use wildcards!?). `[stamp]` can be found with `nslookup`, again see doc above.

3. "Azure IP Address" : find this value in the HCM details screen labeled "Azure IP Address"

Note: various Hybrid docs mention that HCM must have "outbound access to Azure over ports 80 and 443" -- this is the same requirement we are dealing with here.

### Notes

- "New" Hybrid connections always and only communicate over 443. There is no port customization, and even though "80" is mentioned it is never used.

### Security Review

18F performed a security review of the Azure Hybrid Connection, the results are here in [Azure_Hybrid_Connection_Security_Review.pdf](./Azure_Hybrid_Connection_Security_Review.pdf)