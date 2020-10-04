# Azure system configuration 
variable "location" {
  description = "Azure location where the resource exists."
}

variable "environment" {
  description = "application environment"
}

variable "resource_group_name" {
  description = "Azure resource group"
}

variable "vnet_name" {
  description = "vnet name"
}

variable "vnet_address" {
  description = "vnet_address"
}
