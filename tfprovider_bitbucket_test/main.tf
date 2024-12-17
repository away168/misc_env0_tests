resource "env0_environment" "this" {
  name        = "terragrunt bitbucket viaprovider"
  project_id  = "8d129975-4fd9-4ca4-a454-7461a4c75350"
  force_destroy = true

  deploy_on_push = true
  run_plan_on_pull_requests = true
  auto_deploy_on_path_changes_only = true
  auto_deploy_by_custom_glob = "+((infra/_base/s3_private_bucket.hcl)|(infra/environments/dev/env.yaml)|(infra/environments/dev/dev/env.yaml))"

  without_template_settings {
    bitbucket_client_key = "ari:cloud:bitbucket::app/{9e64778b-f6ad-4c6a-89aa-d6b298f96ce0}/env0"
    repository = "https://env0@bitbucket.org/env0/acme-demo.git"
    path = "terragrunt/non-prod/us-west-2/qa/backend"
    revision = "main"
    type = "terragrunt"
    terraform_version = "1.5.0"
    opentofu_version = "1.8.2"
    terragrunt_tf_binary = "opentofu"
    terragrunt_version = "0.67.2"
    is_terragrunt_run_all = false
    description = "testapp-s3_private_bucket"
  }
}

terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = ">=1.20"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.47.0"
    }
  }
}

# Configure the env0 provider

provider "env0" {
}

provider "aws" {
  region = "us-east-1"
}