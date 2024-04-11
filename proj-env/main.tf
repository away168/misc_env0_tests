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

resource "env0_project" "proj-foo" {
  name        = "proj-foo"
  description = "Example project"
  parentProjectId = "789cb1fc-6907-4b58-b8fd-eb47ed356085"
}

resource "env0_environment" "env-foo" {
  name        = "env-foo"
  project_id  = env0_project.proj-foo.id
  template_id = "0830c0ac-45ae-4256-8b20-17019dfd127f"
}