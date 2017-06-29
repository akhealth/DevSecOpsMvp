# Powershell

We will demonstrate Powershell with AzureRM module.  Also the mostly equivalent cross-platform `az` CLI.

## CLI

If you want to use the cross-platform CLI, download and install it here: [https://github.com/Azure/azure-cli](https://github.com/Azure/azure-cli)

az CLI reference: [https://docs.microsoft.com/en-us/cli/azure/](https://docs.microsoft.com/en-us/cli/azure/)

```sh
az login
az account list
```

Copy environment exammple and customize
```sh
cp .env.bash.example .env.bash
source .env.bash
```

See `./create-vm.bash` for a script that will create a new Azure VM

## Powershell

Install Powershell: [https://github.com/PowerShell/PowerShell](https://github.com/PowerShell/PowerShell#get-powershell)
Yes, this is Open Source. Soon it should work on a Mac.  Not all powershell modules are available for OSX yet.  AzureRM should be soon.

Note: there is lots of development here right now, it seems like the easiest way to get a viable AzureRM PS environment is to click the link under "Command-line tools" -> "PowerShell" -> "Windows Install" on this page [https://azure.microsoft.com/en-us/downloads/](https://azure.microsoft.com/en-us/downloads/)

Documentation for AzureRM cmdlets: [https://msdn.microsoft.com/en-us/library/mt125356.aspx](https://msdn.microsoft.com/en-us/library/mt125356.aspx)

```ps1
Install-Module AzureRM
Import-Module AzureRM

Login-AzureRMAccount
```

See `./create-vm.ps1` for a script that will create a new Azure VM