terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = "1.18.4"
    }
  }
}

provider "env0" {
  # Configuration options
}

locals {
  project_id = "6422fc97-70f0-4358-a24f-04ebde645a52"  // dev playgroun / andrew / workflow_test
  template_id = "310d7ce0-02fe-4de5-8f02-d2658fd3689f"
}

resource "env0_environment" "example" {
  name                       = "tf provider test of autodeploy"
  project_id                 = local.project_id
  template_id                = local.template_id
  approve_plan_automatically = true
  force_destroy              = true
  workspace                  = "foo-12345"
  is_inactive                = false
  prevent_auto_deploy        = true

  # dynamic "sub_environment_configuration" {
  #   for_each = toset (["vpc", "eks"])
  #   content {
  #     alias = sub_environment_configuration.key
  #     revision = "main"

  #     configuration {
  #         name = "ENV0_TERRAFORM_CONFIG_FILE_PATH"
  #         value = "${sub_environment_configuration.key}.tfvars"
  #         type = "environment"
  #     }
  #   }
  # }

  configuration {
    name  = "PREFIX"
    value = "FOO_2024_04_26"
    type  = "environment"
  }
}