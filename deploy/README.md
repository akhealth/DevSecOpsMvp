# Automated Deployment

We want to do our deployment from VSTS Build or Release.
Below are a couple ways to make this happen.

## Setup1 : IaaS

First, we need a storage account and container to hold our built software.  Here's a snippit using the `az` cli. We may want to use Terraform or something else if this pans out.

```sh
name="staging0deploy0assets"
rg="StagingDeploy"
loc="westus2"
container="aspnetapp"

az group create --name $rg --location $loc
az storage account create --name $name --resource-group $rg --location $loc --sku "Standard_LRS"
az storage container create --name $container --account-name $name 
```

Most pieces of this deployment model are sketched out in this repo, here's an overview

1. Our build pipeline builds the app and sends artifacts to the Storage Account above
2. Our pipeline syncs the current DSC scripts to Azure Automation.
3. DSC pulls release from AzureStorage and installs it

Updating a version number in DSC will therefore inform all VMs to install new software

TODO: This is only sketched out, not fully working.
- Finish Terraform VM Extension to join AA
- Finish DSC to setup VM for Kestrel behind IIS Reverse Proxy
- Install ASP.Net Core Module (and hand-written web.config?) via DSC
- Finish DSC to install/restart app from Azure Storage
- Finish syncing DSC files to AA during build
- Finish syncing build to Azure Storage (AzureFileCopy)
- DSC for Auto-Shutdown of staging VMs at night

 

## Setup2: PaaS

[Azure App Service](https://azure.microsoft.com/en-us/services/app-service/) is like a PaaS.
We can push our sample .NET Core app to this service with a Build or Release step in VSTS.

I think it [might be possible](https://docs.microsoft.com/en-us/azure/app-service-web/web-sites-integrate-with-vnet) to hook this service up to an on-prem server via VPN by putting it in an Azure Vnet that is connected to on-prem.

We use two scripts here `start-azure-app.ps1`, `stop-azure-app.ps1` that start and stop the Azure App service on either sie of the built-in deploy task.  VSTS also has a Task Type that is "Azure Powershell Script" that should run PS commands in the context of our Azure, which would turn those into 1 line scripts.

TODO: Automate or at least document the VSTS Build / Release setup
