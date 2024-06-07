terraform {
  backend "s3" {
    bucket = "bucket-aelion-tf-2406-boris-backend"
    # if static env var  
    key    = "dev/terraform.tfstate"
    region = "eu-west-3"
    # if static env var  (dev-state-locking-table)
    dynamodb_table = "state-locking-table"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_conf_obj.region
  access_key = var.aws_conf_obj.access_key
  secret_key = var.aws_conf_obj.secret_key
}