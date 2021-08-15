variable "project" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "default"
}

variable "vpc_cidr_block" {
  default = "10.20.0.0/16"
}

variable "subnet_count" {
  default     = 3
  description = "(optional) subnet count for private & public"
}

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

variable "k8s_version" {
  default = "1.20.4"
}