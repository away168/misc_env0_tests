resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-sales-rg"
  location = var.location
  tags     = local.terratag_added_main
}

variable "prefix" {
  type    = string
  default = "env0"
}

variable "location" {
  type    = string
  default = "eastus2"
}
locals {
  terratag_added_main = {"env0_environment_id"="32259b39-bdce-410f-bad0-54ada61c26f8","env0_project_id"="1a81071f-7f1f-4d53-be6c-0c42a23af152"}
}

