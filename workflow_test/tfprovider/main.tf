terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = "1.18.1"
    }
  }
}

provider "env0" {
  # Configuration options
}

locals {
    project_id = "6422fc97-70f0-4358-a24f-04ebde645a52"  // dev playgroun / andrew / workflow_test
}

data "env0_template" "example" {
  name = "test-workflow"
}

resource "env0_environment" "example" {
  name                       = "tf provider test of workflow"
  project_id                 = local.project_id
  template_id                = data.env0_template.example.id
  approve_plan_automatically = true

  sub_environment_configuration {
    alias = "vpc"
    revision = "main"

    configuration {
        name = "ENV0_TERRAFORM_CONFIG_FILE_PATH"
        value = var.vpc_config_var
        type = "environment"
    }
  }

  sub_environment_configuration {
    alias = "eks"
    revision = "main"

    configuration {
        name = "ENV0_TERRAFORM_CONFIG_FILE_PATH"
        value = "TEST_VALUE"
        type = "environment"
    }
  }
}

variable "vpc_config_var" {
    type = string
    default = "2024-APR-18"
}