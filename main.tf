terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Adjust to the desired version
    }
  }
}

provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

module "vpc" {
  source = "./vpc"

  vpc_cidr          = "90.0.0.0/20"
  subnet_cidr       = "90.0.1.0/24"
  availability_zone = "us-east-1a"
  vpc_name          = "CustomVPC"
  igw_name          = "CustomIGW"
  subnet_name       = "CustomSubnet"
  route_table_name  = "CustomRouteTable"
}

# EC2 Instances - Dynamically Provision Multiple Instances
module "ec2_instances" {
  source = "./ec2"

  for_each        = var.ec2_instances
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.subnet_id
  instance_name_suffix = each.key

  ami             = each.value.ami
  instance_type   = each.value.instance_type

  providers = {
    aws = aws
  }
}

output "associated_ec2_instance_ids" {
  value = module.vpc.associated_ec2_instance_ids
}

output "associated_ec2_public_ips" {
  value = module.vpc.associated_ec2_public_ips
}