output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks_managed_cluster.name
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_managed_cluster.kube_config_raw
}

output "aks_sp_clientid" {
  value = azuread_application.aks.application_id
}

output "aks_sp_clientpwd" {
  value = azuread_service_principal_password.aks_sp_pwd.value
}