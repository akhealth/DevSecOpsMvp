# This script is run as a step in our build pipeline.
#  It authenticates with Azure and uploads our configurations to AzureAutomation.
#  The $env variables below must be set in the build pipeline

# Try to figure out how to access VSTS ENV Variables
Param(
  [string]$user,
  [string]$pass,
  [string]$tenant
)

Write-Host "()()())()()()()()()()()()()()()()"
Write-Host $user
Write-Host $pass
Write-Host $tenant
Write-Host "()()())()()()()()()()()()()()()()"


Write-Host "User*** $env:AzureSpUser ***"
Write-Host "Pass*** $env:AzureSpPass ***"
Write-Host "Ten*** $env:AzureSpTenant ***"

#Get-AzureRMContext

#Get-VstsTaskVariable

###############
###############

$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force

$creds = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)

Write-Host "***********************"
Write-Host $creds.UserName
Write-Host $creds.Password
Write-Host "***********************"

#Get-AzureRMContext
Login-AzureRmAccount -Credential $creds -ServicePrincipal -TenantId $tenant
Get-AzureRMContext