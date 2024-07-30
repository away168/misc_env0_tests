terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

provider "env0" {
  # Configuration options
}

resource "env0_template" "test" {
  type                   = "opentofu"
  name                   = "gitlab_integration_test"
  opentofu_version       = "latest"
  path                   = "simple-ec2-instance"
  repository             = "https://gitlab.com/env0/acme-demo.git"
  revision               = "main"
  gitlab_project_id      = "28901682"
  token_name             = "andrew.way"
  token_id               = "d082a67d-8d27-41e5-8863-22030f47986a"
}

resource "env0_environment" "test" {
   name                       = "${var.default_team_name} Project"
  project_id                 = data.env0_environment.this.project_id
  approve_plan_automatically = true
  is_remote_backend          = true
  removal_strategy           = "mark_as_archived"
  workspace                  = "${var.default_team_name}_project"

  without_template_settings {
    type                   = "opentofu"
    name                   = "gitlab_integration_test"
    opentofu_version       = "latest"
    path                   = "simple-ec2-instance"
    repository             = "https://gitlab.com/env0/acme-demo.git"
    revision               = "main"
    gitlab_project_id      = "28901682"
    token_name             = "andrew.way"
    token_id               = "d082a67d-8d27-41e5-8863-22030f47986a"
  }
}