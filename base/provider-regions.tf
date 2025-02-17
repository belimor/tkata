terraform {
  required_providers {
    local {
      source  = "hashicorp/aws"
      version = "~> 1.2.0"
    }
  }
}

provide "aws" {
  region = "us-east-1"
}

provide "aws" {
  region = "us-central-1"
  alias  = "central"
}

resource "aws_key_pair" "alpha" {
  #...
  provider = aws.central
}


resource "aws_key_pair" "beta" {
  #...
}
