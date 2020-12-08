# Azure-AD Application for Service Principal
resource "azuread_application" "aks" {
  name = "${var.project}-aks-sp"
}

# AKS Service Principal
resource "azuread_service_principal" "aks_sp" {
  application_id = azuread_application.aks.application_id
}

resource "random_string" "password" {
  length  = 32
  special = true

  # avoids pwd regeneration by maping pwd to azure-sp-id 
  keepers = {
    service_principal = azuread_service_principal.aks_sp.id
  }
}

# Create Service Principal password
resource "azuread_service_principal_password" "aks_sp_pwd" {
  service_principal_id = azuread_service_principal.aks_sp.id
  value                = random_string.password.result
  end_date             = "2099-12-30T23:00:00Z"

  # lifecycle prevents end_date modification in next run
  lifecycle {
    ignore_changes = [end_date]
  }
}

resource "azurerm_role_assignment" "aks-contributor" {
  scope                = var.resource_group_id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.aks_sp.id
}
