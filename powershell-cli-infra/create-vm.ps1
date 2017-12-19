$Location = "West US 2"
$Group = "dotnettest"

New-AzureRmResourceGroup -Name $Group -Location $Location
#Remove-AzureRMResourceGroup -name $Group

# Create a network
$subnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name subnet1 -AddressPrefix 10.0.1.0/24

$vnet = New-AzureRmVirtualNetwork -ResourceGroupName $Group -Location $Location `
    -Name vnet1 -AddressPrefix 10.0.0.0/16 -Subnet $subnetConfig

# Create a public IP address and specify a DNS name
$pip = New-AzureRmPublicIpAddress -ResourceGroupName $Group -Location $Location `
    -AllocationMethod Static -IdleTimeoutInMinutes 4 -Name "$Group-$(Get-Random)"

# Network Security Group to allow RDP and web
$nsgRuleRDP = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleRDP  -Protocol Tcp `
    -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * `
    -DestinationPortRange 3389 -Access Allow

$nsgRuleWeb = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleWWW  -Protocol Tcp `
    -Direction Inbound -Priority 1001 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * `
    -DestinationPortRange 80 -Access Allow

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $Group -Location $Location `
    -Name RDPandWeb -SecurityRules $nsgRuleRDP,$nsgRuleWeb

# Network Card
$nic = New-AzureRmNetworkInterface -Name NIC -ResourceGroupName $Group -Location $Location `
    -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id


# Create a VM
#TODO: automate me
$cred = Get-Credential

$vmConfig = New-AzureRmVMConfig -VMName TestVM -VMSize Standard_A1_v2 | `
    Set-AzureRmVMOperatingSystem -Windows -ComputerName testVM -Credential $cred | `
    Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer `
    -Skus 2016-Datacenter -Version latest | Add-AzureRmVMNetworkInterface -Id $nic.Id

New-AzureRmVM -ResourceGroupName $Group -Location $Location -VM $vmConfig

# You can RDP to this address
Get-AzureRmPublicIpAddress -ResourceGroupName $Group | Select IpAddress