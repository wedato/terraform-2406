resource "local_file" "my_first_file" {
  content = "# Hello terraform!"
  filename = "${path.module}/hello.md"
}