# image_catalog["key"]  
output "image_catalog" {
  value = docker_image.image_catalog
  description = "Array of images DL by the module and its resource docker_image.image_catalog"
}