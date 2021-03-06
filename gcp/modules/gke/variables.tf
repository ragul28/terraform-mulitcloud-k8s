variable "gcp_project_id" {}
variable "gcp_region" {}
variable "gcp_zone" {}
variable "project_name" {}

variable "gke_vpc" {}
variable "gke_subnet" {}

variable "gke_subnet_secondary_ip_range" {}

variable "gke_username" {
  default     = ""
}

variable "gke_password" {
  default     = ""
}

variable "node_count" {
  description = "number of gke nodes"
}

variable "instance_type" {
  default = "e2-medium"
}

variable "enable_preemptible" {
  default = false
}

variable "gke_env_mode" {
  default = ""
}