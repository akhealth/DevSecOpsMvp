# Terraform

Download and install [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html).
Or `brew install terraform` on OSX.  Or `choco install terraform` on WIN.

## az CLI


## Configuration
The `azurerm` TF provider takes some inputs for authentication.  [Full Instructions](https://www.terraform.io/docs/providers/azurerm/#to-create-using-azure-cli-)

Download and install the CLI here: [https://github.com/Azure/azure-cli](https://github.com/Azure/azure-cli).
`az login` to authenticate your CLI. Or ask an admin to do this:

```sh
# Get your subscription_id (just labeled "id" in the output of this command)
az account show

# Create Service Principal
# Overview here: https://www.terraform.io/docs/providers/azurerm/#creating-credentials
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$subscription_id"
```

You will need these outputs from the command, they go into your environment file. Some names differ between `az` and `terraform`
- "name" = "client_id"
- "password" = "client_secret"
- "tenant" = "tenant_id"

Copy and customize the environment file: `cp terraform.tfvars.example terraform.tfvars`

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