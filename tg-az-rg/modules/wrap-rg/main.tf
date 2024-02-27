module "wrap-rg" {
  source = "../../modules/azure-rg"

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