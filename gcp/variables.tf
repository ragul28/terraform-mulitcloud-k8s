variable "project" {
  default = "tfeks-test"
}

variable "gcp_region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  default = "10.20.0.0/16"
}

variable "node_count" {
  default = 3
}

variable "instance_type" {
  default = "n1-standard-1"
}

variable "gke_username" {
  default = ""
}

variable "gke_password" {
  default = ""
}