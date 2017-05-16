# Terraform

> [Terraform](https://www.terraform.io/intro/index.html) is a tool for building, changing, and versioning infrastructure safely and efficiently.

Download and install [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html).
Or `brew install terraform` on OSX.  Or `choco install terraform` on WIN.

## Azure access with Service Principal
The `azurerm` TF provider takes some inputs for authentication.  [Full Instructions](https://www.terraform.io/docs/providers/azurerm/#to-create-using-azure-cli-)

Generating the Service Principal requires Azure ActiveDirectory access, so maybe ask your admin to create the SP.
Generating the SP is easiest with the `az` CLI.
Download and install the CLI here: [https://github.com/Azure/azure-cli](https://github.com/Azure/azure-cli).

```sh
az login

# Get your subscription_id (just labeled "id" in the output of this command)
az account show

# Create Service Principal
# Overview here: https://www.terraform.io/docs/providers/azurerm/#creating-credentials
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$subscription_id"
```

### Authentication Variables
You will need these outputs from the command, they go into your environment file. Some names differ between `az` and `terraform`
- "name" = "client_id"
- "password" = "client_secret"
- "tenant" = "tenant_id"

## Use

### Setup
Copy the environment file: `cp terraform.tfvars.example terraform.tfvars`.
Use the authentication variables from above to customize `terraform.tfvars`.

Variables and their defaults are defined in `variables.tf`.
Secrets and variables without defaults are defined in `terraform.tfvars`.

### Running
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