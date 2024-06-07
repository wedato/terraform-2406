resource "docker_image" "image_catalog" {
  for_each = toset(var.images_names)
  name = each.key
}