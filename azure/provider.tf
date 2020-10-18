provider "azurerm" {
  version = "=2.30.0"
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "azuread" {
  version = "=1.0.0"
}