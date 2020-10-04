variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "project" {
  default = "tf-eks-test"
}

variable "subnet_count" {
  default     = 3
  description = "(optional) subnet count for private & public"
}