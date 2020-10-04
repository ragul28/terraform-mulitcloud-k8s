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

output "mysql_host" {
  value = module.azure-mysql.mysql_host
}

output "mysql_servername" {
  value = module.azure-mysql.mysql_servername
}

output "mysql_user" {
  value = module.azure-mysql.mysql_user
}

output "mysql_password" {
  value = module.azure-mysql.mysql_password
}

output "key_vault_name" {
  value = module.azure-key-vault.key_vault_name
}

output "redis_hostname" {
  value = module.azure-redis.redis_hostname
}

output "redis_ssl_port" {
  value = module.azure-redis.redis_ssl_port
}

output "redis_primary_access_key" {
  value = module.azure-redis.redis_primary_access_key
}

output "aks_sp_clientid" {
  value = module.azure-aks.aks_sp_clientid
}

output "aks_sp_clientpwd" {
  value = module.azure-aks.aks_sp_clientpwd
}