variable "images" {
  description = "All necessary images"
  type = list(string)
  # if no default value => required (to initialize before plan/apply...) 
}

variable "volumes_names" {
  description = "All necessary modules"
  type = list(string)
  # if no default value => required (to initialize before plan/apply...) 
  default = ["db_data", "wp_data"] 
}

variable "db_vars" {
  description = "All necessary values for MariaDB"
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