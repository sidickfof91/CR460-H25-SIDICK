terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "remote" {
    organization = "CR460SEEDEEK"

    workspaces {
      name = "CR460-H25-SIDICK"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "ef6f84c9-7e4a-49a1-b390-4df9d30c8923"
  client_id       = "1a3e2f02-57cb-45b2-8741-c93d5afc9fa5"
  client_secret   = "0jS8Q~vonio-mDQdt491DP5UyzTf6dFSj.eqrbFK"
  tenant_id       = "e8dd862d-223a-4c23-b0b5-f1e7234a9be5"
}

resource "azurerm_resource_group" "example" {
  name     = "CR460SIDICK-G1-resources"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "CR460SIDICK-G1-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.location
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "exemple-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "CR460SIDICK-G1-VM25V1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_virtual_network.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Xlm@4510"
  network_interface_ids = [
    azurerm_network_interface.example.id
  ]
  os_disk {
    name                 = "example-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}


