resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-sales-rg"
  location = var.location
}

variable "prefix" {
  type = string
  default = "env0"
}

variable "location" {
  type = string
  default = "westus3"
}