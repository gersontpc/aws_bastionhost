variable "instance_type" {
  type    = string
  default = "t2.nano"
}

variable "instance_name" {
  type    = string
  default = "bastionhost"
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
