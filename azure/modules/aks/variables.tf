# AKS cluster configuration
variable "location" {}
variable "resource_group_name" {}
variable "resource_group_id" {}

variable "project" {}
variable "environment" {}

variable "subscription_id" {}

variable "cluster_name" {
  description = "cluster name"
}

variable "k8s_version" {
  description = "Kubernetes version"
}

variable "dns_prefix" {
  description = "DNS prefix (Optional)"
  default     = ""
}

variable "main_subnet_id" {}

# worker node configuration# worker node configuration
variable "node_prefix" {
  description = "DNS name prefix for the worker nodes (aka minions)"
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