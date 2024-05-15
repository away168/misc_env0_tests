terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.103.1"
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
  //subscription_id = "b48787a1-7145-425f-99af-62cde6c50e31"
}

provider "azurerm" {
  alias = "test"
  features {}
  use_oidc = true
  subscription_id = var.second_subscription
}


resource "azurerm_resource_group" "example" {
  name     = "away-may15-rg"
  location =  "eastus2"
}

resource "azurerm_resource_group" "test" {
  provider = azurerm.test
  name     = "away-may15-test-rg"
  location =  "eastus2"
}

variable "second_subscription" {
  type = string
  default = "3ef32f99-33d5-4a4f-bf9c-8a3ebb2b0144"
}