variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "vpc_name" {
  default = "CustomVPC"
}

variable "igw_name" {
  default = "CustomIGW"
}

variable "subnet_name" {
  default = "CustomSubnet"
}

variable "route_table_name" {
  default = "CustomRouteTable"
}