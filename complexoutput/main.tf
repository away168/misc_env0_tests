locals {

}

output "main" {
  value = jsonencode({ 
    endpoint = "core.cluster-c6e7cyvkajcg.eu-west-2.rds.amazonaws.com"
    reader_endpoint = "core.cluster-c6e7cyvkajcg.eu-west-2.rds.amazonaws.com"
    service = {
      username = "gitlab"
      fake_password = "foo"
    }
    flyway = {
      username = "flyway"
      fake_password = "bar"
    }
  })

  sensitive = true
}

