variable "project" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "default"
}

# VPC
variable "main_vpc_cidr_block" {}
variable "secondary_vpc_cidr_blocks" {}

variable "az_set" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "enable_natgw" {

}
# EKS
variable "node_count" {
  default = 2
}

variable "instance_types" {
  default = ["t3.medium", "t3a.medium"]
}

variable "spot_node_count" {
  default = 2
}

variable "spot_instance_types" {
  default = ["t3.medium", "t3a.medium"]
}

variable "eks_version" {
  default = "1.28"
}