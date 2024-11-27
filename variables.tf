variable "ec2_instances" {
  description = "Map of EC2 instance configurations"
  type = map(object({
    ami           = string
    instance_type = string
  }))

  default = {
    instance1 = {
      ami           = "ami-0453ec754f44f9a4a" # Replace with a valid AMI ID
      instance_type = "t2.micro"
    }
    instance2 = {
      ami           = "ami-0453ec754f44f9a4a" # Replace with a valid AMI ID
      instance_type = "t2.micro"
    }
    instance3 = {
      ami           = "ami-0453ec754f44f9a4a" # Replace with a valid AMI ID
      instance_type = "t2.micro"
    }
    instance4 = {
      ami           = "ami-0453ec754f44f9a4a" # Replace with a valid AMI ID
      instance_type = "t2.micro"
    }
  }
}