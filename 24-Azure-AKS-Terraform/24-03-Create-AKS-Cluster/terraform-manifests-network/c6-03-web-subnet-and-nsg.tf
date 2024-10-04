# Resource-1: Create WebTier Subnets
resource "azurerm_subnet" "websubnet1" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name1}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address1
}

resource "azurerm_subnet" "websubnet2" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name2}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address2
}

resource "azurerm_subnet" "websubnet3" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name3}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address3
}

# Resource-2: Create Network Security Groups (NSGs)
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${azurerm_virtual_network.vnet.name}-web-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource-3: Associate NSG with all WebTier Subnets
locals {
  web_subnets = {
    "websubnet1" = azurerm_subnet.websubnet1.id
    "websubnet2" = azurerm_subnet.websubnet2.id
    "websubnet3" = azurerm_subnet.websubnet3.id
  }
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
  for_each                 = local.web_subnets
  subnet_id                = each.value
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id

  depends_on = [azurerm_network_security_rule.web_nsg_rule_inbound]
}

# Resource-4: Create NSG Rules
## Locals Block for Security Rules
locals {
  web_inbound_ports_map = {
    "100" : "80",   # HTTP
    "110" : "443"  # HTTPS

  }
}

## NSG Inbound Rules for WebTier Subnets
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each = local.web_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}