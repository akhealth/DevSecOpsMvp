# Terraform

Download and install [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html).
Or `brew install terraform` on OSX.  Or `choco install terraform` on WIN.

## CLI
We'll use the Azure CLI for various Azure tasks, like getting credentials. It's handy to have.  We'll use the cross-platform CLI for now b/c it should work for everyone. There are also [Powershell Modules](https://docs.microsoft.com/en-us/azure/azure-resource-manager/powershell-azure-resource-manager) that are roughly equivalent.

Download and install the CLI here: [https://github.com/Azure/azure-cli](https://github.com/Azure/azure-cli).
`az login` to authenticate your CLI.

TODO: if we continue here, then document powershell also.

## Configuration
The `azurerm` TF provider takes some inputs for authentication.  [Full Instructions](https://www.terraform.io/docs/providers/azurerm/#to-create-using-azure-cli-)

```sh
az account show
# subscription_id="{:id}"

#TODO: Terraform is **blocked** here, I don't have the permissions necessary to create an SP.
# This could be a manual step?  Overview here: https://www.terraform.io/docs/providers/azurerm/#creating-credentials

#ActiveDirectory ServicePrincipal CreateForRoleBasedAccessControl
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$subscription_id"
```

## Use

Build infrastructure
```sh
cd terraform
terraform plan
terraform apply
terraform show
```

Change infrastructure
```sh
terraform plan
terraform apply
```

Destroy infrastructure
```sh
terraform plan -destroy
terraform destroy
```