# Azure system configuration 
variable "location" {}
variable "project" {}
variable "environment" {}

variable "subscription_id" {}
variable "tenant_id" {}

variable "vnet_address" {
  default = ["10.40.0.0/16"]
}

# AKS cluster configuration
variable "k8s_version" {
  description = "Kubernetes version"
}

variable "dns_prefix" {
  description = "(Optional) DNS prefix"
  default     = ""
}

# worker node configuration
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

variable "agent_admin_user" {
  description = "Admin username for the first user created on the worker nodes"
  default     = "azadmin"
}

variable "public_key_data" {
  description = "Public key to install for SSH to the nodes - defaults to the running user's .ssh/id_rsa.pub file"
  default     = ""
}
