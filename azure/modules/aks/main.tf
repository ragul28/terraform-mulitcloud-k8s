# AKS cluster Resource
resource "azurerm_kubernetes_cluster" "aks_managed_cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.k8s_version
  dns_prefix          = var.dns_prefix == "" ? var.cluster_name : var.dns_prefix

  # sku_tier            = Free # Paid for SLA

  default_node_pool {
    name            = var.node_prefix
    vm_size         = var.node_vmsize
    os_disk_size_gb = var.node_osdisk_gb
    node_count      = var.node_count

    type                = "VirtualMachineScaleSets"
    availability_zones  = ["1", "2", "3"]
    # enable_auto_scaling = true
    # min_count           = 2
    # max_count           = 4

    vnet_subnet_id  = var.main_subnet_id
  }

  # service principal for aks cluster to create & access resources  
  service_principal {
    client_id     = azuread_application.aks.application_id
    client_secret = azuread_service_principal_password.aks_sp_pwd.value
  }

  network_profile {
    network_plugin    = "azure"
    # network policy to be used with Azure CNI. supports [ azure, calico ]
    network_policy    = "calico" 
    load_balancer_sku = "standard"
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    project = var.project
    created = "terrafrom"
  }

  depends_on = [var.resource_group_name, var.main_subnet_id]
}

#
resource "azurerm_kubernetes_cluster_node_pool" "worker" {
  count = var.enable_spot_worker == true ? 1 : 0

  name                  = "worker"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_managed_cluster.id
  vm_size               = var.spot_worker_vmsize
  os_disk_size_gb       = var.spot_worker_osdisk_gb
  node_count            = var.spot_worker_node_count

  availability_zones  = ["1", "2", "3"]
  # enable_auto_scaling = true
  # min_count           = 1
  # max_count           = 4

  priority = "Spot"
  spot_max_price  = -1
  eviction_policy = "Deallocate"

  tags = {
    project = var.project
    created = "terrafrom"
  }
}