terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
resource "aws_security_group" "custom_sg" {
  vpc_id = var.vpc_id
  name   = "CustomSecurityGroup-${var.instance_name_suffix}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
    Name = "CustomSecurityGroup"
  }
}

resource "aws_instance" "custom_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.custom_sg.id] # Correct argument for VPC

  tags = {
    Name = "CustomEC2Instance-${var.instance_name_suffix}"
  }
}