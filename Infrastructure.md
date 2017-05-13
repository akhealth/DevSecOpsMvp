# Cloud Infrastructure 

We plan to highlight a couple options for cloud-based staging environments.

## Cloud.gov
[Cloud.gov](https://cloud.gov) is Platform as a Service(PaaS) running on AWS and operated by 18F.  It can run .NET Core appliations.
Unfortunately cloud.gov only services federal customers right now. We use it as a free stand-in for other PaaS choices.

First, [Get a cloud.gov](https://cloud.gov/docs/getting-started/accounts/) account and [Set up the CLI](https://cloud.gov/docs/getting-started/setup/)

```
# Set up
cf login -a api.fr.cloud.gov --sso
cf target -o sandbox-gsa -s clinton.troxel

# Deploy
cd  aspnetapp
cf push aspnet-clint

# Get more information
cf apps
cf logs aspnet-clint --recent
open https://aspnet-clint.app.cloud.gov
```

Note: with default setup, we need to comment out `//.UseUrls("http://*:5000/")` in order for this app to run under cloud.gov.  This setting was added to support Docker.

## Azure

We demonstrate the sample app running on a VM in Microsoft Azure.

### Powershell, CLI infrastructure
We can use powershell modules or the Azure CLI to manage Azure VMs.  See more in [`powershell_infra/README.md`](./powershell_infra/README.md)

### Raw ARM infrastructure
With Powershell and CLI we can only run the script.  If a VM exists our script will error.  It does not handle existing infra.
To handle existing infrastructure -- deleting things that aren't supposed to be there, creating things that are missing -- we need to use something like Terraform or raw ARM with mode=complete.

Learn more in [`raw-arm-infra/README.md`](./raw-arm-infra/README.md)

### Terraform
We include an example of using [Terraform](https://terraform.io) to build cloud infrastructure.



