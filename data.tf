# data "aws_caller_identity" "current" {}

data "aws_ami" "amazon2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}


data "aws_key_pair" "personal" {
  key_name = "personal"

  filter {
    name   = "tag:Environment"
    values = ["Development"]
  }
}
