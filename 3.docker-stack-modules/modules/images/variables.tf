# if no default value => not mandatory 
variable "images_names" {
  type    = list(string)
  description = "The names of all images to DL"
  # no default value => required 
}
