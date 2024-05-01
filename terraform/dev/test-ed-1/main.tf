terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = ">=3.2.2"
    }
  }
}

resource "null_resource" "null" {
}

variable "name" {
  type = string
  default = "default name"
}

output "name" {
  value = var.name
}