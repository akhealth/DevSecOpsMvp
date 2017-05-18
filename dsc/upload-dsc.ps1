# This script is run as a step in our build pipeline.
#  It authenticates with Azure and uploads our configurations to AzureAutomation.

# Pass these _hidden/encrypted_ parameters in from the build step
#  the "Arguments" look like `-user "$(AzureSpUser)" -pass "$(AzureSpPass)" -tenant "$(AzureSpTenant)"`
Param(
  [string]$user,
  [string]$pass,
  [string]$tenant
)

# Hidden VSTS variables are redacted from logs
Write-Host "Here is the secret user value: $user"

# Generate creds from secrets
$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)

# Login to Azure using the SP credentials
Login-AzureRmAccount -Credential $creds -ServicePrincipal -TenantId $tenant

# Show Context, prove we're connected from the pipeline
Get-AzureRMContext

# TODO: Actually upload the DSC to AA now that we're connected to Azure