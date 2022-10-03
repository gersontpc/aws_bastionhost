provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "223341017520-tfstate"
    key    = "479610723/bastion_host.tfvars"
    region = "us-east-1"
  }
}
