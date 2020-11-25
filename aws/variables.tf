variable "project" {
  default = "tfeks-test"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  default = "10.20.0.0/16"
}

variable "subnet_count" {
  default     = 3
  description = "(optional) subnet count for private & public"
}

variable "node_count" {
  default = 3
}

variable "instance_types" {
  default = ["t3.medium"]
}

# variable "k8s_version" {}