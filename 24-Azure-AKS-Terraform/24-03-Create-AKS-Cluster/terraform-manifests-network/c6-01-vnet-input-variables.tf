# Virtual Network, Subnets and Subnet NSG's

## Virtual Network
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet-default"
}
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/16"]
}


# Web Subnet Name
variable "web_subnet_name1" {
  description = "Virtual Network Web Subnet Name"
  type = string
  default = "websubnet1"
}
# Web Subnet Address Space
variable "web_subnet_address1" {
  description = "Virtual Network Web Subnet Address Spaces"
  type = list(string)
  default = ["10.0.1.0/24"]
}

# Web Subnet Name
variable "web_subnet_name2" {
  description = "Virtual Network Web Subnet Name"
  type = string
  default = "websubnet2"
}
# Web Subnet Address Space
variable "web_subnet_address2" {
  description = "Virtual Network Web Subnet Address Spaces"
  type = list(string)
  default = ["10.0.2.0/24"]
}

# Web Subnet Name
variable "web_subnet_name3" {
  description = "Virtual Network Web Subnet Name"
  type = string
  default = "websubnet3"
}
# Web Subnet Address Space
variable "web_subnet_address3" {
  description = "Virtual Network Web Subnet Address Spaces"
  type = list(string)
  default = ["10.0.3.0/24"]
}

# Database Subnet Name
variable "db_subnet_name" {
  description = "Virtual Network Database Subnet Name"
  type = string
  default = "dbsubnet"
}
# Database Subnet Address Space
variable "db_subnet_address" {
  description = "Virtual Network Database Subnet Address Spaces"
  type = list(string)
  default = ["10.0.4.0/24"]
}


# App Subnet Name
variable "app_subnet_name1" {
  description = "Virtual Network App Subnet Name"
  type = string
  default = "appsubnet1"
}
# App Subnet Address Space
variable "app_subnet_address1" {
  description = "Virtual Network App Subnet Address Spaces"
  type = list(string)
  default = ["10.0.5.0/24"]
}

# App Subnet Name
variable "app_subnet_name2" {
  description = "Virtual Network App Subnet Name"
  type = string
  default = "appsubnet2"
}
# App Subnet Address Space
variable "app_subnet_address2" {
  description = "Virtual Network App Subnet Address Spaces"
  type = list(string)
  default = ["10.0.6.0/24"]
}

# Bastion / Management Subnet Name
variable "bastion_subnet_name" {
  description = "Virtual Network Bastion Subnet Name"
  type = string
  default = "bastionsubnet"
}
# Bastion / Management Subnet Address Space
variable "bastion_subnet_address" {
  description = "Virtual Network Bastion Subnet Address Spaces"
  type = list(string)
  default = ["10.0.7.0/24"]
}



