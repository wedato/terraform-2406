variable "aws_region" {
  type = string
  description = "My aws region"
}

variable "aws_access_key" {
  type = string
  description = "My aws access key"
}

variable "aws_secret_key" {
  type = string
  description = "My aws secret key"
}

variable "aws_conf" {
  type = map(string)
  description = "My aws conf"
}

# better in object form
variable "aws_conf_obj" {
  type = object({
    region = string
    access_key = string
    secret_key = string
  })
  description = "My aws conf"
}