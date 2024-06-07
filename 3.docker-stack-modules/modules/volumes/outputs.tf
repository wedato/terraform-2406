output "custom_volumes" {
  value = docker_volume.volumes
  description = "Array of volumes created by the module and its resource docker_volume.volumes"
}