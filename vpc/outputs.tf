data "aws_instances" "associated_instances" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.custom_vpc.id]
  }
}
# Expose the VPC ID
output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

# Expose the Subnet ID
output "subnet_id" {
  value = aws_subnet.custom_subnet.id
}