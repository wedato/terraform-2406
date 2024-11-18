resource "local_file" "file_with_env" {
  content  = var.content
  filename = "${path.module}/${terraform.workspace}/.env"
}