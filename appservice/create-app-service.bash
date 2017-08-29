location="westus2"
group_name="prototype-AppService"
service_name="prototype-DevSecOpsMVP"
num_workers="1"

# The pricing tiers, e.g., F1(Free), D1(Shared), B1(Basic Small), B2(Basic Medium), B3(Basic Large), S1(Standard Small),
plan_name="prototype-Standard"
tier="S1"  # Standard tier is required for HybirdConnections.

# Create AppService
az group create --name $group_name --location $location
az appservice plan create --name $plan_name --resource-group $group_name --location $location --number-of-workers $num_workers --sku $tier
az webapp create --name $service_name --plan $plan_name --resource-group $group_name

# Deployment via git:
# Create a deployment user, set up deployment from a local git repo, and get the url that we should push to.
# TODO: There may be a bug in Azure here. If this doesn't work set "Deployment Credentials" manually in the Azure portal.
az webapp deployment user set --user-name $DEPLOY_USER --password $DEPLOY_PASS
url=$(az webapp deployment source config-local-git --name $service_name --resource-group $group_name --query url --output tsv)

# IMPORTANT: Make sure Username in this is correct. $url will look like:  https://PrototypeAlaska@prototype-devsecopsmvp.scm.azurewebsites.net/prototype-DevSecOpsMVP.git
# AzureApps uses Kudu for deployment.  See this url for a cool dashboard: https://prototype-devsecopsmvp.scm.azurewebsites.net/

# Configure local git
git remote add azure $url

# !Deploy the master branch to this AppService!
git push azure master

# Destroy it all
#az group delete --name $group_name