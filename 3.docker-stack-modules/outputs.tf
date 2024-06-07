output "wordpress_container_id" {
  value = docker_container.wordpress.id
  description = "The ID of the Wordpress container"
  sensitive = true
}

output "db_container_id" {
  value = docker_container.db.id
  description = "The ID of the DB container"
}

