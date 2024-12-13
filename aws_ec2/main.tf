provider "aws" {
  region = "us-west-2" # Change to your preferred region
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "prod-key"                    # Replace with your desired key name
  public_key = file("~/.ssh/id_ed25519.pub") # Path to your public SSH key
}

resource "aws_instance" "ssh_instance" {
  ami                         = "ami-00c257e12d6828491" # Replace with a valid AMI ID for your region
  instance_type               = "t2.micro"              # Change instance type as needed
  key_name                    = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ssh_sg.id]

  #root_block_device {
  #  volume_size = 20
  #  tags = {
  #    Name = "prod-tmp"
  #  }
  #}

  tags = {
    Name = "prod-tmp"
    env  = "ansible"
  }
}

resource "aws_security_group" "ssh_sg" {
  name_prefix = "ssh-allow-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  value       = aws_instance.ssh_instance.public_ip
  description = "The public IP address of the instance."
}

