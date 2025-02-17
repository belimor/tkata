
data "aws_key_pair" "cerberus-key" {
  key_name = "alpha"
}


data "aws_key_pair" "cerberus-key1" {
  filter {
    name   = "tag:project"
    values = ["cerberus"]
  }
}
