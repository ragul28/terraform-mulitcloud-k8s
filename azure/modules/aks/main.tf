# azure k8s module
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

# AKS cluster Resource
resource "azurerm_kubernetes_cluster" "aks_managed_cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.k8s_version
  dns_prefix          = var.dns_prefix == "" ? var.cluster_name : var.dns_prefix

  # sku_tier            = Free # Paid for SLA

  default_node_pool {
    name            = var.agent_prefix
    vm_size         = var.agent_vm_sku
    node_count      = var.node_count
    os_disk_size_gb = var.node_os_disk_size_gb

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
