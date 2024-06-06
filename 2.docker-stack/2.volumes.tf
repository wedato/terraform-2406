##########
# 2. volumes
##########

resource "docker_volume" "db_data" {
  name = "db_data"
}

resource "docker_volume" "wp_data" {
  name = "wp_data"
}