# if no default value => not mandatory 
variable "volumes_names" {
  type    = list(string)
  description = "The names of all volumes to create"
  # no default value => required 
}
