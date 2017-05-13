# Azure ARM

Azure Resource Manager scripts are JSON files that describe resources like VMs, Disks, Networks, etc.  All tools that communicate with Azure do it via this language.

See [azure-quickstart-templates](https://github.com/Azure/azure-quickstart-templates) for lots of good examples.

The ARM script here is similar to the CLI outputs captured in `../powershell-infra/`, but has been hand written.

ARM scripts are nice because you can run them over and over again with the same results, unlike using the CLI which would error on duplicate resources.
We can also use "group deployments" which are a nice way to track infrastructure changes.

## Setup

You'll need either Powershell or the Azure CLI installed.  

Copy and fill out the parameters file, it is in `.gitignore` so it won't be added to this repo.
`cp parameters.json.example parameters.json`

## Complete Vs. Incremental
We can run ARM scripts in two modes.
- In **complete** mode, Resource Manager deletes resources that exist in the resource group but are not specified in the template.
- In **incremental** mode, Resource Manager leaves unchanged resources that exist in the resource group but are not specified in the template.

We like _complete_ mode because it prevents infrastructure drift. Terraform is another way to achieve this kind of functionality.
`--mode complete` does not work yet with this simple example.

## Running the ARM script

Azure CLI
```sh
group="infraTest"

az group create --name $group --location westus2
az group deployment create --name $group --resource-group $group --template-file create-vm.json --parameters @parameters.json

# az group delete --name $group
```