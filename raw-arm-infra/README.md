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

PowerShell
```ps1
# assume: service principle is already created (see link below code block)
# TODO: refactor literals in code-block to a separate json file

# set the process environment current directory to the current location in PS
[Environment]::CurrentDirectory = Get-Location -PSProvider FileSystem

# login to Azure
# TODO: configure with credentials pulled from secure/local that work from CLI (no parameters for Login-AzureRmAccount invokes prompted browser credentialing UX, below parameters invokes a username/password dialog UX) 
# current service principal info used to test:
#"appId": "2b3cdb63-d173-40f5-bc4b-d4bb5ea075a8",
#"displayName": "azure-cli-2017-05-15-21-29-36",
#"name": "http://azure-cli-2017-05-15-21-29-36",
#"password": "",
#"tenant": "fe758026-4d70-490b-aa6a-44a20fd0bfca"
$ApplicationId="2b3cdb63-d173-40f5-bc4b-d4bb5ea075a8"
$TenantId="fe758026-4d70-490b-aa6a-44a20fd0bfca"
$PSCredential = Get-Credential -UserName $ApplicationId -Message "Enter Password"
Login-AzureRmAccount -Credential $PSCredential -ServicePrincipal -TenantId $TenantId

# select the specific subscription to work with
# note: might be redundant when logging in with service principal
$SubscriptionName="Visual Studio Enterprise"
Select-AzureRmSubscription -SubscriptionName $SubscriptionName

# create an Azure resource group
$ResourceGroupName="InfraTest"
$Location="westus2"
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location

# Create a deployment based on a template and a parameter file
# note: New-AzureRmResourceGroupDeployment appears to run in working directory C:\WINDOWS\system32\
$DeploymentName="DeploymentTest"
$TemplateFile="create-vm.json"
$TemplateParameterFile="parameters.json"
New-AzureRmResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -TemplateParameterFile $TemplateParameterFile

# to cleanup/teardown the resource group (and deployment):
# Remove-AzureRmResourceGroup -Name $ResourceGroupName -Force
```
For docs on creating an Azure service principle, see [Create a Service Principle](https://docs.microsoft.com/en-us/powershell/azure/create-azure-service-principal-azureps?view=azurermps-3.8.0)