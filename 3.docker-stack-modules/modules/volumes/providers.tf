terraform {
  # dependencies  must be declared in module
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Provider conf can be implicitely inherited from parent / root module
# provider "docker" {
   # Configuration options
# }
