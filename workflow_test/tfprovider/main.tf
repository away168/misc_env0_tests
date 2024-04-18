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
  name        = "environment"
  project_id  = local.project_id
  template_id = data.env0_template.example.id

  sub_environment_configuration {
    alias = "vpc"
    revision = "main"

    configuration {
        name = "MY_ENV_VAR"
        value = "TEST1"
        type = "environment"
    }
  }

  sub_environment_configuration {
    alias = "eks"
    revision = "main"

    configuration {
        name = "MY_ENV_VAR"
        value = "TEST1"
        type = "environment"
    }
  }
}