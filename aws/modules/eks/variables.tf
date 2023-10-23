variable "project" {}
variable "eks_vpc_id" {}
variable "eks_subnet_ids" {}
variable "eks_version" {
  default = "1.28"
}

variable "node_count" {}
variable "max_node_count" {
  default = null
}
variable "min_node_count" {
  default = null
}
variable "instance_types" {}
variable "enable_spot_pool" {
  default = false
}

variable "spot_node_count" {}
variable "spot_instance_types" {}

variable "disk_size" {
  default     = 20
  description = "(optional) Node disk size"
}
