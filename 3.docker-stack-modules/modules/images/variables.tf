# if no default value => not mandatory 
variable "images_names" {
  # TODO: refacto as map (key => value) 
  # to handle it in a more generic ways in outputs
  type    = list(string)
  description = "The names of all images to DL"
  # no default value => required 
}
