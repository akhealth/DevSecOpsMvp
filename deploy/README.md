# Automated Deployment

Deployment happens with DSC And Azure Storage.
A new build will store its contents as a Storage Blob.
Updated DSC will inform VMs to pull the latest app code from Storage.

## Setup

First, we need a storage account and container to hold our built software.  Here's a snippit using the `az` cli. We may wanto to use Terraform or something else if this pans out.

```sh
name="staging0deploy0assets"
rg="StagingDeploy"
loc="westus2"
container="aspnetapp"

az group create --name $rg --location $loc
az storage account create --name $name --resource-group $rg --location $loc --sku "Standard_LRS"
az storage container create --name $container --account-name $name 
```

Our build pipeline sends built assets to this location.