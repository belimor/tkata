resource "aws_security_group" "my-sg" {
  name   = "mname"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    iterator = prort
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = tcp
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "ingress_ports" {
  type    = list(any)
  default = [22, 8080]
}

# splat expression:
output "to_ports" {
  value = aws_security_group.my_sg.ingress[*].to_port
}







