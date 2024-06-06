# Find the latest Ubuntu precise image.
resource "docker_image" "ubuntu" {
  name = "ubuntu:precise"
}

# Start a container
resource "docker_container" "my_container_ubuntu" {
  name  = "my_container_ubuntu_2"
  image = docker_image.ubuntu.image_id
  command = ["sleep", "infinity"]
  env = ["KEY=VALUE2"]
  # dependcy is implicit, but we can specify
  depends_on = [ docker_image.ubuntu ]
}