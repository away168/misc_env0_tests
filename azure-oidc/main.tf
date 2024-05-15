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
  subscription_id = "b48787a1-7145-425f-99af-62cde6c50e31"
}

provider "azurerm" {
  alias = "test"
  features {}
  use_oidc = true
  subscription_id = "3ef32f99-33d5-4a4f-bf9c-8a3ebb2b0144"
}



module "resource-group" {
  source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/resource-group/azurerm"
  version = "1.0.3"

  prefix = "away-may15"
}

module "resource-group-test" {
  alias = "test"
  source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/resource-group/azurerm"
  version = "1.0.3"

  prefix = "away-may15-test"
}