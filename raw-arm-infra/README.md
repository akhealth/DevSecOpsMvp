# Azure ARM

Azure Resource Manager scripts are JSON files that describe resources like VMs, Disks, Networks, etc.  All tools that communicate with Azure do it via this language.

See [azure-quickstart-templates](https://github.com/Azure/azure-quickstart-templates) for lots of good examples.

The ARM script here is similar to the CLI outputs captured in `../powershell-cli-infra/`, but has been hand written.

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
# set the process environment current directory to the current location in PS
[Environment]::CurrentDirectory = Get-Location -PSProvider FileSystem

$ArmVars = (Get-Content "ps-arm-vars.json") -join "`n" | ConvertFrom-Json

# login to Azure
$PWord = ConvertTo-SecureString -String $ArmVars.LoginInfo.Password -AsPlainText -Force
$PSCredential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $ArmVars.LoginInfo.ApplicationId, $PWord
Login-AzureRmAccount -Credential $PSCredential -ServicePrincipal -TenantId $ArmVars.LoginInfo.TenantId

# create an Azure resource group
New-AzureRmResourceGroup -Name $ArmVars.ResourceGroupInfo.Name -Location $ArmVars.ResourceGroupInfo.Location

# Create a deployment based on a template and a parameter file
New-AzureRmResourceGroupDeployment -Name $ArmVars.DeploymentInfo.Name -ResourceGroupName $ArmVars.ResourceGroupInfo.Name -TemplateFile $ArmVars.DeploymentInfo.TemplateFile -TemplateParameterFile $ArmVars.DeploymentInfo.TemplateParameterFile

# to cleanup/teardown the resource group (and deployment):
# Remove-AzureRmResourceGroup -Name $ArmVars.ResourceGroupInfo.Name -Force
```
For docs on creating an Azure service principle, see [Create a Service Principle](https://docs.microsoft.com/en-us/powershell/azure/create-azure-service-principal-azureps?view=azurermps-3.8.0)