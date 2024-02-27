# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  account_name = local.account_vars.locals.account_name
  #account_id   = local.account_vars.locals.aws_account_id
  location   = local.region_vars.locals.location
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
// terraform {
//   required_version = "~>1.3.0"
//}
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.92.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Configuration options
}
EOF
}

// remote_state {
//   backend = "s3"
//   config = {
//     // bucket         = "acme-demo-tfstate-dev"
//     // key            = "${path_relative_to_include()}/terraform.tfstate"
//     // region         = local.aws_region
//     // dynamodb_table = "acme-dev-tfstate-lockdb"
//     bucket         = "env0-acme-tfstate"
//     dynamodb_table = "env0-acme-tfstate-lock"
//     key            = "${path_relative_to_include()}/terraform.tfstate"
//     region         = "us-west-2"
//     role_arn       = "arn:aws:iam::326535729404:role/env0-acme-assume-role"
//   }
//   generate = {
//     path      = "backend.tf"
//     if_exists = "overwrite_terragrunt"
//   }
// }

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)