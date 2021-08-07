module "azure-vnet" {
  source              = "./modules/vnet"
  project             = var.project
  resource_group_name = "${var.project}-rg"
  vnet_name           = "${var.project}-vnet"
  vnet_address        = var.vnet_address
  location            = var.location
}

module "azure-aks" {
  source                 = "./modules/aks"
  project                = var.project
  location               = var.location
  resource_group_name    = module.azure-vnet.resource_group_name
  main_subnet_id         = module.azure-vnet.main_subnet_id
  cluster_name           = "${var.project}-aks"
  k8s_version            = var.k8s_version
  node_vmsize            = var.node_vmsize
  node_count             = var.node_count
  enable_spot_worker     = var.enable_spot_worker
  spot_worker_vmsize     = var.spot_worker_vmsize
  spot_worker_node_count = var.spot_worker_node_count
}