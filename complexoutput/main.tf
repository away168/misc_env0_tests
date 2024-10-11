locals {

}

output "main" {
  value = { 
    endpoint = "https"
    reader_endpoint = "bar"
    service = {
      username = "gitlab"
      password = "bar"
    }
    flyway = {
      username = "flyway"
      password = "bar"
    }
  }
}
