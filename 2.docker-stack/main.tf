##########
# 1. networks
# 2. volumes 
##########

##########
# 1. networks
##########

resource "docker_network" "wordpress_network" {
  name = "wordpress_network"
}

##########
# 2. volumes
##########

resource "docker_volume" "db_data" {
  name = "db_data"
}

resource "docker_volume" "wp_data" {
  name = "wp_data"
}

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
  hostname = "db"
  restart = "always"
  env = [
    "MYSQL_ROOT_PASSWORD=somewordpress",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=wordpress",
  ]
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
  env = [
    "WORDPRESS_DB_HOST=db:3306",
    "WORDPRESS_DB_USER=wordpress",
    "WORDPRESS_DB_PASSWORD=wordpress",
    "WORDPRESS_DB_NAME=wordpress",
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