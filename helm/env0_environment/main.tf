terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = ">= 1.18.12"
    }
  }
}

provider "env0" {
  # Configuration options
}

resource "env0_environment" "helm" {
  project_id  = "9ab305ff-3c4b-4354-9f1d-7a78b87a8d54" # Andrew > Helm Test
  template_id = "504dd2e8-30a1-4b9d-819e-52257f72d688" # helm nginx template

  name      = "argo-requisites-${var.environment}"
  workspace = "argo-requisites-${var.environment}"
  k8s_namespace                    = "misc-tests"
  
  revision                         = "main"
  is_remote_backend                = true
  run_plan_on_pull_requests        = true
  deploy_on_push                   = true
  auto_deploy_on_path_changes_only = true
  prevent_auto_deploy              = true
  auto_deploy_by_custom_glob       = "+((_env0/modules/environment/sre/devops/**)|($${env0_template_dir_path}/**))"
  approve_plan_automatically       = null
  ttl                              = null
  
  configuration {
    type        = "environment"
    name        = "ENV0_HELM_SET_environment"
    value       = var.environment
    is_required = true
    schema_um   = null
  }
}

variable "environment" {
  type    = string
  default = "dev"
}