provider "azurerm" {
  version = "=2.0.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "ptsopstfstates-rg"
    storage_account_name = "ptsopstf"
    container_name       = "ptsopstfscontainer"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "pts-appsre-test-rg" {
  name     = "pts-appsre-test-rg-the-second"
  location = "eastus"
}
