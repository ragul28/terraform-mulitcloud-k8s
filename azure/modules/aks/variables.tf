# AKS cluster configuration
variable "location" {}
variable "resource_group_name" {}
variable "resource_group_id" {}

variable "project" {}

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

# worker node configuration
variable "agent_prefix" {
  description = "DNS name prefix for the worker nodes (aka minions)"
  default     = "worker"
}

variable "agent_vm_sku" {
  description = "Azure VM SKU for the agent/worker nodes B2s, DS1_v2, DS2_v2, D2s_v3"
}

variable "node_os_disk_size_gb" {
  description = "Size in GB of the node's OS disks"
  default     = 30
}

variable "node_count" {
  description = "Number of worker nodes"
}

variable "main_subnet_id" {
  description = "main subnet id"
}

