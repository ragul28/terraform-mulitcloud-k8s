terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.74.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
