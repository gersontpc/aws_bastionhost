provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = module.default_tags.tags
  }
}
# terraform {
#   backend "s3" {
#     bucket = "1234567890-tfstate"
#     key    = "hosts/bastion_host.tfstate"
#     region = "us-east-1"
#   }
# }
