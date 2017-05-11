location="West US 2"
group="dotnettest"
vmname="testVM"

az group create --location "$location" --name $group 

# Destroy the resource group to quickly delete all contained resources
# az group delete --name $group

az vm create --resource-group $group --name $vmname \
    --image win2016datacenter --admin-username <changeme> --admin-password <changeme> \
    --size Standard_A1_v2 --storage-sku Standard_LRS



