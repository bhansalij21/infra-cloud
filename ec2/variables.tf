variable "vpc_id" {
  description = "ID of the VPC"
}

variable "subnet_id" {
  description = "ID of the Subnet"
}

variable "instance_name_suffix" {
  description = "Suffix for EC2 instance name"
}

variable "ami" {
  description = "AMI for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}