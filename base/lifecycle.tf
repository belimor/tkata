resource "aws_instance" "web1" {
  #...

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "web2" {
  #...

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_instance" "web3" {
  #...

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


