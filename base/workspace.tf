
resource "aws_instance" "my_ec2" {
  #...

  instance_type = lookup(var.instance_type, terraform.workspace)
}

variable "instance_type" {
  type = map(any)
  default = {
    dev  = "t2.micro"
    prod = "t2.small"
  }
}
