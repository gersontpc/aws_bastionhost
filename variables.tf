variable "instance_type" {
  type    = string
  default = "t2.nano"
}

variable "instance_name" {
  type    = string
  default = "bastionhost"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Set subnet ids"
}

variable "vpc_id" {
  type        = string
  description = "Insert VPC ID"
}

variable "volume_size" {
  type        = number
  description = "Change volume block size"
  default     = 100
}

variable "tags" {
  type        = map(string)
  description = "Insert default tags"
  default = {
    "Environment" = "Development",
    "Time"        = "Ops"
  }
}

# CloudWatch

variable "retention_in_days" {
  type        = number
  description = "Set days for expires logs"
  default     = 7
}

variable "service_name" {}
variable "feature_name" {}
variable "owner_email" {}
variable "tech_owner_email" {}
variable "environment" {}
variable "squad" {}
variable "finops" {}
variable "repo_name" {}
variable "pipeline" {}
variable "tier" {}
variable "sigla" {}
variable "sn" {}
variable "account_id" {}
