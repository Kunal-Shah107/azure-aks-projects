# Resource-1: Create AppTier Subnet
resource "azurerm_subnet" "appsubnet1" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.app_subnet_name1}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_address1 
}

resource "azurerm_subnet" "appsubnet2" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.app_subnet_name2}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_address2 
}

# Resource-2: Create Network Security Group (NSG)
resource "azurerm_network_security_group" "app_subnet_nsg" {
  name                = "${azurerm_virtual_network.vnet.name}-app-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource-3: Associate NSG with all AppTier Subnets
locals {
  app_subnets = {
    "appsubnet1" = azurerm_subnet.appsubnet1.id
    "appsubnet2" = azurerm_subnet.appsubnet2.id
  }
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_associate" {
  for_each                 = local.app_subnets
  subnet_id                = each.value
  network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id

  depends_on = [azurerm_network_security_rule.app_nsg_rule_inbound]
}

# Resource-4: Create NSG Rules
## Locals Block for Security Rules
locals {
  app_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443"
  } 
}
## NSG Inbound Rule for AppTier Subnets
resource "azurerm_network_security_rule" "app_nsg_rule_inbound" {
  for_each = local.app_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.app_subnet_nsg.name
}


