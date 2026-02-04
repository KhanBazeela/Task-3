terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "tls_private_key" "deployer" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = tls_private_key.deployer.public_key_openssh
}

resource "local_file" "private_key" {
    content  = tls_private_key.deployer.private_key_pem
    filename = "${path.module}/deployer-key.pem"
    file_permission = "0600"
}

resource "aws_instance" "example" {
    ami           = "ami-055a9df0c8c9f681c"
    instance_type = "t2.micro"
    key_name      = aws_key_pair.deployer.key_name

    tags = {
        Name = "MyEC2Instance"
    }

    depends_on = [aws_key_pair.deployer]
}