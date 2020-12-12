variable "project" {}
variable "eks_vpc_id" {}
variable "eks_subnet_ids" {}

variable "node_count" {}
variable "instance_types" {}
variable "spot_node_count" {}
variable "spot_instance_types" {}

variable "disk_size" {
  default     = 20
  description = "(optional) Node disk size"
}

