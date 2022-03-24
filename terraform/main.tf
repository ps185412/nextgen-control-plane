terraform {
  backend "azurerm" {
    resource_group_name  = "ptsopstfstates-rg"
    storage_account_name = "ptsopstf"
    container_name       = "ptsopstfscontainer"
    key                  = "ptsopstfscontainer.tfstate"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}
 
data "azurerm_client_config" "current" {}
 
#Create Resource Group
resource "azurerm_resource_group" "ptsops" {
  name     = "ptsops"
  location = "northcentralus"
}
 
#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "ptsopstest-vnet"
  address_space       = ["10.100.0.0/16"]
  location            = "northcentralus"
  resource_group_name = azurerm_resource_group.ptsops.name
}
 
# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.ptsops.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.100.100.0/24"
}