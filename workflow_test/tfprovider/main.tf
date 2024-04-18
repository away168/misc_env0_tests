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

## the template that the workflows use
resource "env0_template" "template" {
  name                   = "workflow_null_resource_template"
  description            = "Null Resource Template"
  repository             = "https://github.com/away168/misc_env0_tests"
  path                   = "workflow_test/template"
  opentofu_version       = "latest"
  type                   = "opentofu"
  github_installation_id = 16766458
}

## the workflow temlate itself
resource "env0_template" "workflow" {
  name                   = "workflow_test_template"
  description            = "Null Resource Template"
  repository             = "https://github.com/away168/misc_env0_tests"
  path                   = "workflow_test/workflow_2"
  type                   = "workflow"
  github_installation_id = 16766458
}

# ## configuration used in workflow
# resource "env0_configuration_variable" "workspace_prefix" {
#   name        = "WORKSPACE_PREFIX"
#   value       = "FOO"
#   type        = "environment"
#   template_id = env0_template.workflow.id 
# }

resource "env0_environment" "example" {
  name                       = "tf provider test of workflow"
  project_id                 = local.project_id
  template_id                = env0_template.workflow.id 
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
        value = "eks.tfvars"
        type = "environment"
    }
  }
}

variable "vpc_config_var" {
    type = string
    default = "vpc.tfvars"
}