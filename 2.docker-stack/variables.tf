
variable "db_vars" {
  type = map(string)
  # if no default value => required (to initialize before pla/apply...) 
  default = {
    "MYSQL_HOSTNAME" = "db",
    "MYSQL_ROOT_PASSWORD" = "wordpressroot"
    "MYSQL_DATABASE" = "wordpressdb"
    "MYSQL_USER" = "wordpressdbu"
    "MYSQL_PASSWORD" = "wordpressuser"
  }
  # declare as a secret ("secret like") 
  sensitive = true
}