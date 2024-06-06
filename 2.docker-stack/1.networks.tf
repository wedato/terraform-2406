##########
# 1. networks
##########

resource "docker_network" "wordpress_network" {
  name = "wordpress_network"
}