# Cloud Infrastructure 
We explore a couple options for cloud-based environments.

## Infrastructure as a Service

### Azure: Powershell, CLI infrastructure
We can use powershell modules or the Azure CLI to manage Azure VMs.  See more in [`powershell-cli-infra/README.md`](./powershell-cli-infra/README.md)

### Azure: Raw ARM infrastructure
With Powershell and CLI we can only run the script.  If we run this script twice it will error.  It does not handle existing infra.
For deleting things that aren't supposed to be there, creating things that are missing, updating things that are changed -- we need to use something like Terraform or raw ARM with mode=complete.

Learn more in [`raw-arm-infra/README.md`](./raw-arm-infra/README.md)

### Azure: Terraform
We include an example of using [Terraform](https://terraform.io) to build cloud infrastructure.

Learn more in [`terraform/README.md`](./terraform/README.md)

## Platform as a Service

### Azure App Service
Azure App Service is more like a Platform-as-a-Service for .NET Apps.
The VSTS Build pipeline also easily deploys to this service.
There is also a **Free** plan limited to 60min/day of non-resting time.

The AppService also supports connecting to on-prem resources via the Azure Hybrid Connection.

Learn more in [`appservice/README.md`](./appservice/README.md) and [`hybrid-connection/README.md`](./hybrid-connection/README.md)

## Cloud.gov
[Cloud.gov](https://cloud.gov) is Platform as a Service(PaaS) running on AWS and operated by 18F.  It can run .NET Core appliations.
Unfortunately cloud.gov only services federal customers right now. It stands as a proxy for things like [Heroku](https://heroku.com) and [CloudFoundry](https://www.cloudfoundry.org/platform/).

First, [Get a cloud.gov](https://cloud.gov/docs/getting-started/accounts/) account and [Set up the CLI](https://cloud.gov/docs/getting-started/setup/)

```
# Set up
cf login -a api.fr.cloud.gov --sso
cf target -o sandbox-gsa -s clinton.troxel

# Deploy
dotnet new mvc --name aspnetapp
cd  aspnetapp
cf push aspnet-clint

# Get more information
cf apps
cf logs aspnet-clint --recent
open https://aspnet-clint.app.cloud.gov
```