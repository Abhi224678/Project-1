
provider "aws" {
  region = "ap-south-1"
}

# Find the existing Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = false
  owners      = ["099720109477"]

  name_regex = "^ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20261109$"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Reuse the existing default VPC
data "aws_vpc" "default" {
  default = true
}

# Reuse the existing public subnet
data "aws_subnet" "public" {
  id = "subnet-0391feeb69966b00f"
}

# Create a dedicated security group
resource "aws_security_group" "web" {
  name        = "capstone-project1-web-sg-2026"
  description = "HTTP access for Capstone Project 1 web server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "capstone-project1-web-sg"
    Project = "Capstone-Project-1"
  }
}

# Launch EC2 web server
resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data_replace_on_change = true

  user_data = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
    echo "<h1>Capstone Project 1 - Terraform EC2 Web Server</h1>" > /var/www/html/index.html
  EOT

  tags = {
    Name    = "Capstone-Project1-EC2"
    Project = "Capstone-Project-1"
  }
}

# Outputs
output "instance_id" {
  value = aws_instance.web.id
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "website_url" {
  value = "http://${aws_instance.web.public_ip}"
}
