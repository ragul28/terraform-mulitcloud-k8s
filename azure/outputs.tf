output "cluster_name" {
  value = module.azure-aks.cluster_name
}

output "kube_config" {
  value = module.azure-aks.kube_config
}

output "subscription_id" {
  value = var.subscription_id
}

output "resource_group_name" {
  value = module.azure-vnet.resource_group_name
}

output "aks_sp_clientid" {
  value = module.azure-aks.aks_sp_clientid
}

output "aks_sp_clientpwd" {
  value = module.azure-aks.aks_sp_clientpwd
}