data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "c89e9161-8350-44a5-81cf-9eb26605e195"
    workspaces = {
      name = "VPC-57019-82697596"
    }
  }
}

output vpc {
  value = data.terraform_remote_state.vpc.outputs
}