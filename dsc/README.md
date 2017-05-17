# Desired State Configuration

We're using DSC to configure a VM.

## Azure Automation
DSC works best with a Pull Server like [Azure Automation](https://docs.microsoft.com/en-us/azure/automation/automation-intro).
You'll have to ask an admin to [create a new Automation Account in the Azure Portal](https://portal.azure.com/#create/Microsoft.AutomationAccount).

There are [Powershell cmdlets](https://docs.microsoft.com/en-us/powershell/module/azurerm.automation/?view=azurermps-1.7.0) that can automate some of this.

### Getting DSC to Azure Automation
Use the pipeline.