location="westus2"
group_name="staging-app-service"
service_name="DevOpsMVP-staging"
num_workers="1"

# The pricing tiers, e.g., F1(Free), D1(Shared), B1(Basic Small), B2(Basic Medium), B3(Basic Large), S1(Standard Small),
plan_name="DevOpsMVP-free"
tier="F1"

# Create AppService
az group create --name $group_name --location $location
az appservice plan create --name $plan_name --resource-group $group_name --location $location --number-of-workers $num_workers --sku $tier
az appservice web create --name $service_name --plan $plan_name --resource-group $group_name

# Deployment via git
# TODO: There may be a bug in Azure here.  If the remote service does not authenticate your `deploy_user` and `deploy_pass`, then you might have to add these "Deployment Credentials" manually in the Azure portal.
# Create a deployment user, set up deployment from a local git repo, and get the url that we should push to.
az appservice web deployment user set --user-name $DEPLOY_USER --password $DEPLOY_PASS
url=$(az appservice web source-control config-local-git --name $service_name --resource-group $group_name --query url --output tsv)

# $url will look like: https://AKAzureAdmin@devopsmvp-staging.scm.azurewebsites.net/DevOpsMVP-staging.git
# AzureApps uses Kudu for deployment.  See this url for a cool dashboard: https://devopsmvp-staging.scm.azurewebsites.net/

# Configure local git
git remote add azure $url

# !Deploy the master branch to this AppService!
git push azure master

# Destroy it all
#az group delete --name $group_name