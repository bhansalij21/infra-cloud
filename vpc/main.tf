provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = var.igw_name
  }
}

# Create a Public Subnet
resource "aws_subnet" "custom_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags = {
    Name = var.subnet_name
  }
}

# Create a Route Table
resource "aws_route_table" "custom_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }

  tags = {
    Name = var.route_table_name
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "custom_rta" {
  subnet_id      = aws_subnet.custom_subnet.id
  route_table_id = aws_route_table.custom_route_table.id
}

# Fetch all EC2 instances in the VPC


output "associated_ec2_instance_ids" {
  value = data.aws_instances.associated_instances.ids
}

output "associated_ec2_public_ips" {
  value = data.aws_instances.associated_instances.public_ips
}