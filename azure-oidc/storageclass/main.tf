terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.103.1"
    }
  }
}


# terraform {
#   backend "azurerm" {
#     resource_group_name  = "sales-acme-demo"
#     storage_account_name = "sales-acme-demo-storage-accnt"
#     container_name       = "test"
#     key                  = "acme.tfstate"
#     subscription_id      = "3ef32f99-33d5-4a4f-bf9c-8a3ebb2b0144"
#     use_azuread_auth     = true
#     use_oidc             = true
#   }
# }

# PROVIDER 
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

data "azurerm_resource_group" "one" {
  name     = "sales-acme-demo"
}

# Generate random text for a unique storage account name
resource "random_id" "one" {
  byte_length = 5
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "one" {
  name                     = "sales${random_id.one.hex}"
  location                 = data.azurerm_resource_group.one.location
  resource_group_name      = data.azurerm_resource_group.one.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
variable "container_name" {
  type = string
}

resource "azurerm_storage_container" "example" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.one.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.one.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
}


####
# Second Subscription

variable "second_subscription" {
  type = string
  default = "3ef32f99-33d5-4a4f-bf9c-8a3ebb2b0144"
}

### RESOURCES

resource "azurerm_resource_group" "two" {
  provider = azurerm.test

  name     = "env0sales${random_id.random_id.hex}"
  location =  "eastus2"
}

# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  byte_length = 5
}
# Create storage account for boot diagnostics
resource "azurerm_storage_account" "two" {
  provider = azurerm.test

  name                     = "env0sales${random_id.random_id.hex}"
  location                 = azurerm_resource_group.two.location
  resource_group_name      = azurerm_resource_group.two.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "two" {
  provider = azurerm.test

  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.two.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "two" {
  provider = azurerm.test

  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.two.name
  storage_container_name = azurerm_storage_container.two.name
  type                   = "Block"
}
