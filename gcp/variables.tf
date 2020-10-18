variable "project" {
}

variable "gcp_region" {
  description = "If only region defined regional cluster is created."
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "If zone defined, zonal cluster created."
  default     = ""
}

variable "vpc_cidr_block" {
  default = "10.20.0.0/16"
}

variable "node_count" {
  default = 1
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