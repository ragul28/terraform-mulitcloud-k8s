# Azure system configuration 
variable "location" {}
variable "project" {}

variable "subscription_id" {}
variable "tenant_id" {}
variable "client_id" {}
variable "client_secret" {}

variable "vnet_address" {
  default = ["10.20.0.0/16"]
}

# AKS cluster configuration
variable "k8s_version" {
  description = "Kubernetes version > 1.16.12"
}

variable "dns_prefix" {
  description = "(Optional) DNS prefix"
  default     = ""
}

# worker node configuration
variable "agent_prefix" {
  description = "DNS name prefix for the worker nodes (aka minions)"
  default     = "worker"
}

variable "agent_vm_sku" {
  description = "Azure VM SKU for the agent/worker nodes B2s, DS1_v2, B2ms, D2_v2, D2s_v3"
}

variable "node_os_disk_size_gb" {
  description = "Size in GB of the node's OS disks"
  default     = 30
}

variable "node_count" {
  description = "Number of worker nodes"
}

variable "agent_admin_user" {
  description = "Admin username for the first user created on the worker nodes"
  default     = "azadmin"
}

variable "public_key_data" {
  description = "Public key to install for SSH to the nodes - defaults to the running user's .ssh/id_rsa.pub file"
  default     = ""
}
