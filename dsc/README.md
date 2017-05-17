# Desired State Configuration

We're using DSC to configure a VM.

## Azure Automation
DSC works best with a Pull Server like [Azure Automation](https://docs.microsoft.com/en-us/azure/automation/automation-intro).
You'll have to ask an admin to [create a new Automation Account in the Azure Portal](https://portal.azure.com/#create/Microsoft.AutomationAccount).

There are [Powershell cmdlets](https://docs.microsoft.com/en-us/powershell/module/azurerm.automation/?view=azurermps-1.7.0) that can automate some of this.

## Pipeline authentication
Pipeline tasks will need to authenticate with Azure in order to do things like upload DSC.
Get ServicePrincipal account details from your administrator.
For now I'm going to use the Terraform SP, see `../terraform/README.md` for more info

### Getting DSC to Azure Automation
We upload DSC from the master branch into Azure Automation using Powershell scripts checked in here.
The build definition will require setting the following variables:
`azuresp-user, azuresp-tenantid, azuresp-pass`, which are associated with the SP user mentioned above.