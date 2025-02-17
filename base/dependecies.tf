
resource "aws_instance" "db" {
  #...
}

resource "aws_instance" "web" {
  #...
  depends_on = [
    aws_instance.db
  ]
}
