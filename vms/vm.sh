# MY IP - 101.161.74.194
# create resource group
az group create --name rgtest --location eastus

# creaye virtual network
az network vnet create --resource-group rgtest --location eastus --name vnettest --address-prefix 10.0.0.0/16 \
--subnet-name subnet1 --subnet-prefix 10.0.1.0/24


# create a network security group
az network nsg create  --resource-group rgtest --name nsgtest

# create  NSG rules - Allow Inbound traffic on port 80
az network nsg rule create  --resource-group rgtest  --nsg-name nsgtest  --name inboundRule80  --protocol tcp  --direction inbound \
--source-address-prefixes '*'  --source-port-range '*'  --destination-address-prefix '*'  --destination-port-range 80  --access allow \
--priority 200

# create  NSG rules - Allow Inbound traffic on port 22
az network nsg rule create  --resource-group rgtest  --nsg-name nsgtest  --name inboundRule80  --protocol Any  --direction inbound \
--source-address-prefixes '*'  --source-port-range '*'  --destination-address-prefix '*'  --destination-port-range 22  --access allow \
--priority 201


# create public IP for VM1
az network public-ip create --resource-group rgtest --name publicIPvm1test

# create Network Interface Card for VM1
az network nic create  --resource-group rgtest  --name nicvm1test  --vnet-name vnettest  --subnet subnet1 \
--public-ip-address publicIPvm1test --network-security-group nsgtest

# create Virtual Machine VM1
az vm create --resource-group rgtest --name vm1test  --nics nicvm1test  --image UbuntuLTS  --generate-ssh-keys  --custom-data cloud-init.txt

# create public IP for VM2
az network public-ip create --resource-group rgtest --name publicIPvm2test

# create Network Interface Card for VM2
az network nic create  --resource-group rgtest  --name nicvm2test  --vnet-name vnettest  --subnet subnet1 \
--public-ip-address publicIPvm2test --network-security-group nsgtest 

# create Virtual Machine VM2
az vm create --resource-group rgtest --name vm2test  --nics nicvm2test  --image UbuntuLTS  --generate-ssh-keys  --custom-data cloud-init.txt 

# create public IP for VM3
az network public-ip create --resource-group rgtest --name publicIPvm3test

# create Network Interface Card for VM3
az network nic create  --resource-group rgtest  --name nicvm3test  --vnet-name vnettest  --subnet subnet1  \
--public-ip-address publicIPvm3test --network-security-group nsgtest 

# create Virtual Machine VM3
az vm create --resource-group rgtest --name vm3test  --nics nicvm3test  --image UbuntuLTS  --generate-ssh-keys  --custom-data cloud-init.txt 

# create a role definition
az role definition create --role-definition role-defn.json

# list custom roles
az role definition list --custom-role-only true
