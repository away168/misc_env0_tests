terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = "1.18.0"
    }
  }
}

provider "env0" {
  # Configuration options
}

locals {
  template_id = "0830c0ac-45ae-4256-8b20-17019dfd127f"
}

resource "env0_template_project_assignment" "assignment" {
  template_id = local.template_id
  project_id  = data.env0_project.default_project.id
}

resource "env0_project" "proj-foo" {
  name        = "proj-foo"
  description = "Example project"
  parent_project_id = "789cb1fc-6907-4b58-b8fd-eb47ed356085"
}

resource "env0_environment" "env-foo" {
  name        = "env-foo"
  project_id  = env0_project.proj-foo.id
  template_id = "0830c0ac-45ae-4256-8b20-17019dfd127f"
}