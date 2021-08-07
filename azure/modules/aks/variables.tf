# AKS cluster configuration
variable "location" {}
variable "resource_group_name" {}
variable "project" {}

variable "cluster_name" {}
variable "k8s_version" {}
variable "main_subnet_id" {}

variable "dns_prefix" {
  description = "DNS prefix (Optional)"
  default     = ""
}

# worker node configuration# worker node configuration
variable "node_prefix" {
  description = "DNS prefix for the worker nodes"
  default     = "worker"
}

variable "node_vmsize" {
  description = "Worker nodes sku Standard_B2s, Standard_D2_v4, Standard_D2s_v4"
}

variable "node_osdisk_gb" {
  description = "Size in GB of the node's OS disks"
  default     = 30
}

variable "node_count" {
  description = "Number of worker nodes"
  default = 1
}

variable "node_username" {
  default = "aksadmin"
}

variable "enable_spot_worker" {
  default = false
}

variable "spot_worker_vmsize" {
  description = "Worker nodes sku Standard_B2s, Standard_D2_v4, Standard_D2s_v4"
  default = "Standard_D2_v4"
}

variable "spot_worker_osdisk_gb" {
  description = "Size in GB of the node's OS disks"
  default     = 30
}

variable "spot_worker_node_count" {
  description = "Number of Spot worker nodes"
  default = 1
}

variable "load_balancer_sku" {
  description = "basic or standard sku"
  default = "basic"
}