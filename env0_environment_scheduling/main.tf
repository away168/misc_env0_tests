terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = "~> 1.18.5"
    }
  }
}

locals {
    environment_id = "63a4a4e1-501f-4617-8b41-a46a7238c73c"
}

resource "env0_environment_scheduling" "environment_scheduling" {
  environment_id = local.environment_id
  deploy_cron    = "45 21 * * 0,2,7"
  destroy_cron   = null
}