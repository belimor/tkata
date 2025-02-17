resource "aws_instance" "web1" {
  #...
  tags = local.common_tags
}

resource "aws_instance" "web2" {
  #...
  tags = local.common_tags
}

locals {
  common_tags = {
    department = "web"
    project    = "cobra"
  }
}
