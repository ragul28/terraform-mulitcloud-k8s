output "cluster_name" {
  value = module.azure-aks.cluster_name
}

output "kube_config" {
  value = module.azure-aks.kube_config
}

output "resource_group_name" {
  value = module.azure-vnet.resource_group_name
}