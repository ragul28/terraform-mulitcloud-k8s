module "azure-vnet" {
  source              = "./modules/vnet"
  project             = var.project
  resource_group_name = "${var.project}-rg"
  vnet_name           = "${var.project}-vnet"
  vnet_address        = var.vnet_address
  location            = var.location
}

module "azure-aks" {
  source              = "./modules/aks"
  project         = var.project
  resource_group_name = module.azure-vnet.resource_group_name
  cluster_name        = "${var.project}"
  location            = var.location
  k8s_version         = var.k8s_version
  agent_vm_sku        = var.agent_vm_sku
  node_count          = var.node_count
  subscription_id     = var.subscription_id
  main_subnet_id      = module.azure-vnet.main_subnet_id
  resource_group_id   = module.azure-vnet.resource_group_id
}