##########
# 1. networks
# 2. volumes 
# ...
##########

##########
# 1. networks
##########

# in 1.networks.tf 

##########
# 2. volumes
##########

# in 2.volumes.tf

##########
# images
##########

resource "docker_image" "mariadb" {
  name         = "mariadb:10.6.4-focal"
  keep_locally = false # delete image on destroy 
}

resource "docker_image" "wordpress" {
  name         = "wordpress:latest"
  keep_locally = false # delete image on destroy 
} 

##########
# containers 
##########

resource "docker_container" "db" {
  image = docker_image.mariadb.image_id
  name  = "db"
  hostname = var.db_vars.MYSQL_HOSTNAME
  restart = "always"
  # static env vars 
  # env = [
  #   "MYSQL_ROOT_PASSWORD=${var.db_vars.MYSQL_ROOT_PASSWORD}",
  #   "...
  # ]
  # dynamic env vars with for expression 
  env = [for key, value in var.db_vars : "${key}=${value}"]
  volumes {
    volume_name    = docker_volume.db_data.name
    container_path = "/var/lib/mysql"
  }
  networks_advanced {
    name = docker_network.wordpress_network.name
  }
}

resource "docker_container" "wordpress" {
  image = docker_image.wordpress.image_id
  name  = "wordpress"
  restart = "always"
  # static usage of vars 
  env = [
    "WORDPRESS_DB_HOST=${var.db_vars.MYSQL_HOSTNAME}:3306",
    "WORDPRESS_DB_USER=${var.db_vars.MYSQL_USER}",
    "WORDPRESS_DB_PASSWORD=${var.db_vars.MYSQL_PASSWORD}",
    "WORDPRESS_DB_NAME=${var.db_vars.MYSQL_DATABASE}",
  ]
  ports {
    internal = 80
    external = 8888
  }
  volumes {
    volume_name    = docker_volume.wp_data.name
    container_path = "/var/www"
  }
  networks_advanced {
    name = docker_network.wordpress_network.name
  }
  depends_on = [ # explicit dependency (not mandatory)
    docker_image.wordpress,
    docker_volume.wp_data,
    docker_network.wordpress_network,
    docker_container.db,  
  ]
}