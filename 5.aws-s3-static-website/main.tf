resource "aws_s3_bucket" "example" {
  bucket = "bucket-aelion-tf-2406-boris"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}