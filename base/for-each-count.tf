resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = 3
}

var "webservers" {
  type    = list
  default = ["web0", "web1", "web2"]
}

resource "aws_instance" "web_new" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = length(var.webservers)
  tags = {
    Name = var.webservers[count.index]
  }
}

var "new_webservers" {
  type    = set
  default = ["web0", "web1", "web2"]
}


resource "aws_instance" "new" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = var.new_webservers
  tags = {
    Name = each.value
  }
}
