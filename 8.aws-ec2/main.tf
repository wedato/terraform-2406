# Define a security group to allow SSH, HTTP, and HTTPS traffic
resource "aws_security_group" "web_access" {
  name        = "2411-web-access"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere; restrict as needed
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTPS from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define an EC2 instance
resource "aws_instance" "my_server" {
  ami           = "ami-045a8ab02aadf4f88" # a valid Ubuntu AMI ID for eu-west-3
  instance_type = "t2.micro"              # Free-tier eligible instance type
  key_name      = "cesi-devops-2304-key"   # Replace with your existing key pair name
  security_groups = [aws_security_group.web_access.name]

  tags = {
    Name = "my-ec2-server"
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.my_server.public_ip
}
