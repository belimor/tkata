provider "aws" {
  region  = "us-east-1"
  profile = "LA"
}

#token is in the file: ~/.terraformrc
terraform {
  backend "remote" {
    organization = "FLYHT"

    workspaces {
      name = "test"
    }
  }
}

# Create a VPC to launch our instances into
resource "aws_vpc" "vpc_test" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "tkata"
  } 
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "igw_test" {
  vpc_id = "${aws_vpc.vpc_test.id}"
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = "${aws_vpc.vpc_test.id}"
  route_table_id = "${aws_route_table.route_t_test.id}"
}


resource "aws_route_table" "route_t_test" {
  vpc_id = "${aws_vpc.vpc_test.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw_test.id}"
  }

  tags = {
    Name = "tkata"
  }
}

# Create a subnet to launch our instances into
resource "aws_subnet" "dev_network" {
  vpc_id                  = "${aws_vpc.vpc_test.id}"
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "open_ssh" {
  name        = "terraform_example"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.vpc_test.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_network_interface" "dev_interface" {
  subnet_id   = "${aws_subnet.dev_network.id}"
  security_groups = ["${aws_security_group.open_ssh.id}"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmjo9MYL9XieWkP0E0bC4MrjVHXaq0yg+MDRwJkGzLUztZrjhSbA0lxPLr9nTWcm7f3hreznwiz86v7YiCVUA7Bpl7RxkNEZZhDhEE/t+5VQPYF7GEyp6hZLBbjTou/HXwBDXlBQT80cTgJ/F9lk7soPObArtIwoMtvIJDdusz4h4aTPfgxFzTjnOomlbQSzxYWFCmwhSNgn54KgXVZFuSBHrM2NfDY7Rm72PjBdZsb3Qh0PoEHciq8bz1hdEApo2SH1mfZZ8Uel4jhQ/K/rB+UDTGU5RIVse8d4bwqt8LQUQC9wy0KiCUC5sQEiV8o4moZNWg+GIgZAn5Sii9VMAp root@mycentos.localdomain"
}

resource "aws_instance" "web" {
  #ami             = "${data.aws_ami.ubuntu.id}"
  ami             = "ami-00068cd7555f543d5"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.deployer.id}"

  network_interface {
    network_interface_id = "${aws_network_interface.dev_interface.id}"
    device_index         = 0
  }

  tags = {
    Name = "HelloWorld"
  }
}

