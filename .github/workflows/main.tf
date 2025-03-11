
terraform {
  required_version = ">= 1.5.0"

  cloud {
    organization = "CR460SEEDEEK"

    workspaces {
      name = "CR460-H25-SIDICK"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.74.0"
    }
  }

  
}
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
    }