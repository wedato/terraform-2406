##########
# 1. networks
# 2. volumes 
# ...
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

module "volumes" {
  source = "./modules/volumes"
  volumes_names = var.volumes_names # set as variable  
}

##########
# images
##########

module "images" {
  source = "./modules/images"
  images_names = var.images
}

##########
# containers 
##########

resource "docker_container" "db" {
  image = module.images.image_catalog["mariadb:10.6.4-focal"].image_id
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
    volume_name    = module.volumes.custom_volumes["db_data"].name 
    container_path = "/var/lib/mysql"
  }
  networks_advanced {
    name = docker_network.wordpress_network.name
  }
}

resource "docker_container" "wordpress" {
  image = module.images.image_catalog["wordpress:latest"].image_id
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
    volume_name    = module.volumes.custom_volumes["wp_data"].name
    container_path = "/var/www"
  }
  networks_advanced {
    name = docker_network.wordpress_network.name
  }
  depends_on = [ # explicit dependency (not mandatory)
    module.images.image_catalog,
    module.volumes.custom_volumes,
    docker_network.wordpress_network,
    docker_container.db,  
  ]
}