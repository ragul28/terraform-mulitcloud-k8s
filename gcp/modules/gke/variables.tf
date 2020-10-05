variable "project" {}
variable "gcp_region" {}

variable "gke_vpc" {}
variable "gke_subnet" {}


variable "gke_username" {
  default     = ""
}

variable "gke_password" {
  default     = ""
}

variable "node_count" {
  default     = 3
  description = "number of gke nodes"
}

variable "instance_type" {
  default = "n1-standard-1"
}