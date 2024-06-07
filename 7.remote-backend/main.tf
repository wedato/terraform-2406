resource "aws_s3_bucket" "website_bucket" {
  bucket = "bucket-aelion-tf-2406-boris-test-backend"

  tags = {
    Name        = "My static bucket with remote backend"
  }
}