# Azure resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-rg"
  location = var.location
}

# azure VNet
resource "azurerm_virtual_network" "azure_vnet" {
    name                = var.vnet_name
    address_space       = var.vnet_address
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    tags = {
        project = var.project
        terrafrom = true
    }
}

# azure subnet
resource "azurerm_subnet" "subnet" {
  name                 = "main-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name

  # Taking the second /24 subnet from the first IP range of the virtual network
  address_prefixes            = [cidrsubnet(azurerm_virtual_network.azure_vnet.address_space[0], 8, 0)]
  depends_on                = [azurerm_network_security_rule.http]
  
  # lifecycle {
  #   ignore_changes = [route_table_id,network_security_group_id]
  # }
}

# azure subnet nsg
resource "azurerm_network_security_group" "nsg" {
  name                = "main-subnet-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# azure nsg rule
resource "azurerm_network_security_rule" "http" {
  name                        = "AllowHttp"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 101
  description                 = "Allow HTTP"
  source_address_prefix       = "Internet"
  direction                   = "Inbound"
  destination_port_ranges     = ["80", "443"] 
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_address_prefix  = "*"
}

# azure subnet <-> nsg association
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

output "main_subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "main_subnet" {
  value = azurerm_subnet.subnet.address_prefix
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}