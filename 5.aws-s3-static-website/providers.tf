terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_conf_obj.region
  access_key = var.aws_conf_obj.access_key
  secret_key = var.aws_conf_obj.secret_key
}