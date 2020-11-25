# variables
variable "project" {}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_count" {
  default     = 3
  description = "(optional) subnet count for private & public"
}