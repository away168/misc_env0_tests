terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = "1.18.12"
    }
  }
}

provider "env0" {
  # Configuration options
}

resource "env0_template" "test" {
  name                   = "template-test-tg-az-rg"
  opentofu_version       = "latest"
  path                   = "tg-az-rg/non-prod/us-west-2/qa/azurerg"
  repository             = "https://github.com/away168/misc_env0_tests"
  # retries_on_deploy      = 0
  # retries_on_destroy     = 0
  revision               = "main"
  github_installation_id = "16766458"
  # ssh_keys               = [
  #     {
  #         "id"   = "ba1baaf8-f7de-4dce-9bca-a87e70dfe430"
  #         "name" = "helios-cloudops-ssh-key"
  #     },
  # ]
  terraform_version      = "RESOLVE_FROM_TERRAFORM_CODE"
  terragrunt_tf_binary   = "opentofu"
  terragrunt_version     = "0.57.8"
  type                   = "terragrunt"
}