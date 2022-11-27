provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "1234567890-tfstate"
    key    = "hosts/bastion_host.tfstate"
    region = "us-east-1"
  }
}
