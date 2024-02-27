module "wrap-rg" {
  source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/resource-group/azurerm"
  version = "1.0.0"

  prefix = var.prefix
  location = var.location
}

variable "prefix" {
  type = string
  default = "env0"
}

variable "location" {
  type = string
  default = "eastus2"
}