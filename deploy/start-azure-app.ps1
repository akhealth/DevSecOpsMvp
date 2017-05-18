# This script is run as a step in our build pipeline.
#  It authenticates with Azure and starts an Azure App

# Pass these _hidden/encrypted_ parameters in from the build step
#  the "Arguments" look like `-user "$(AzureSpUser)" -pass "$(AzureSpPass)" -tenant "$(AzureSpTenant)" -appname "$(AzureAppName)" -appgroup "$(AzureAppGroup)"`
Param(
  [string]$user,
  [string]$pass,
  [string]$tenant,
  [string]$appname,
  [string]$appgroup
)

# Generate creds from secrets
$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
# Login to Azure using the SP credentials
Login-AzureRmAccount -Credential $creds -ServicePrincipal -TenantId $tenant

# Stop the Azure App
Start-AzureRmWebapp -Name $appname -ResourceGroupName $appgroup