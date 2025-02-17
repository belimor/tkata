resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("~/.ssh/web")
  }
}

resource "aws_instance" "web1" {
  ami           = var.ami
  instance_type = var.instance_type

  provisioner "local-exec" {
    command = "echo ${aws_instance.web1.public_ip} >> ./instance.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo ${aws_instance.web1.public_ip} >> ./instance.txt"
  }

  provisioner "local-exec" {
    on_failure = fail ### continue
    command    = "echo ${aws_instance.web1.public_ip} >> ./instance.txt"
  }

}


resource "aws_instance" "web2" {
  ami           = var.ami
  instance_type = var.instance_type

  user_data = <<-EOF
              #!/usr/bin/bash
              sudo apt update
              sudo apt install nginx -y
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF
}

