# if no default value => not mandatory 
variable "volumes_names" {
  # TODO: refacto as map (key => value) 
  # to handle it in a more generic ways in outputs 
  type    = list(string)
  description = "The names of all volumes to create"
  # no default value => required 
}
