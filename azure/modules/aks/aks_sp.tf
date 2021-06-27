# Azure-AD Application for Service Principal
resource "azuread_application" "aks" {
  display_name = "${var.project}-aks-sp"
}

# AKS Service Principal
resource "azuread_service_principal" "aks_sp" {
  application_id = azuread_application.aks.application_id
}

# Create Service Principal password
resource "azuread_service_principal_password" "aks_sp_pwd" {
  display_name = "${var.project}-aks-sp-pwd"
  service_principal_id = azuread_service_principal.aks_sp.id
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
