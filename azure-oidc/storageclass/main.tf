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


terraform {
  backend "azurerm" {
    resource_group_name  = "sales-acme-demo"
    storage_account_name = "sales-acme-demo-storage-accnt"
    container_name       = "tstate"
    key                  = "wan-eu-test-gwc.tfstate"
    subscription_id      = "3ef32f99-33d5-4a4f-bf9c-8a3ebb2b0144"
    use_azuread_auth     = true
    use_oidc             = true
  }
}

data "azurerm_storage_account" "this" {
  name                = "env0acmedemoazstorage"
  resource_group_name = "sales-acme-demo"
}

variable "container_name" {
  type = string
}

resource "azurerm_storage_container" "example" {
  name                  = var.container_name
  storage_account_name  = data.azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = data.azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
}


####
# Second Subscription

variable "second_subscription" {
  type = string
  default = "3ef32f99-33d5-4a4f-bf9c-8a3ebb2b0144"
}

# PROVIDER 
provider "azurerm" {
  alias = "test"
  features {}
  use_oidc = true
  subscription_id = var.second_subscription
}

### RESOURCES

resource "azurerm_resource_group" "test" {
  provider = azurerm.test
  name     = "away-may15-test-rg"
  location =  "eastus2"
}

# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = data.azurerm_resource_group.rg.name
  }
  byte_length = 8
}
# Create storage account for boot diagnostics
resource "azurerm_storage_account" "this" {
  provider = azurerm.test

  name                     = "env0sales${random_id.random_id.hex}"
  location                 = azurerm_resource_group.test.location
  resource_group_name      = azurerm_resource_group.test.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
}
