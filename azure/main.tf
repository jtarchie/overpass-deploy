terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# Variables
variable "resource_group_name" {
  description = "Resource Group Name"
  default     = "myResourceGroup"
}

variable "location" {
  description = "Azure Region"
  default     = "eastus"
}

variable "storage_account_name" {
  description = "Storage Account Name"
}

variable "file_share_name" {
  description = "File Share Name"
  default     = "acishare"
}

variable "OVERPASS_META" {
  description = "Environment variable for OVERPASS_META"
  default     = "yes"
}

variable "OVERPASS_MODE" {
  description = "Environment variable for OVERPASS_MODE"
  default     = "init"
}

variable "OVERPASS_PLANET_URL" {
  description = "Environment variable for OVERPASS_PLANET_URL"
  default     = "https://download.geofabrik.de/north-america/us-latest.osm.bz2"
}

variable "OVERPASS_RULES_LOAD" {
  description = "Environment variable for OVERPASS_RULES_LOAD"
  default     = "10"
}

variable "container_port" {
  description = "Port to expose on the container"
  default     = 80
}

# Resources
resource "azurerm_resource_group" "aci_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "aci_sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.aci_rg.name
  location                 = azurerm_resource_group.aci_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "aci_share" {
  name                 = var.file_share_name
  storage_account_name = azurerm_storage_account.aci_sa.name
  quota                = 5
}

resource "azurerm_container_group" "aci_container" {
  name                = "overpassapi"
  location            = azurerm_resource_group.aci_rg.location
  resource_group_name = azurerm_resource_group.aci_rg.name
  os_type             = "Linux"

  container {
    name   = "overpassapi"
    image  = "wiktorn/overpass-api"
    cpu    = "0.5"
    memory = "1.5"

    environment_variables = {
      OVERPASS_META       = var.OVERPASS_META
      OVERPASS_MODE       = var.OVERPASS_MODE
      OVERPASS_PLANET_URL = var.OVERPASS_PLANET_URL
      OVERPASS_RULES_LOAD = var.OVERPASS_RULES_LOAD
    }

    ports {
      port     = var.container_port
      protocol = "TCP"
    }

    volume {
      name                 = "overpassdb"
      mount_path           = "/db"
      share_name           = azurerm_storage_share.aci_share.name
      storage_account_name = azurerm_storage_account.aci_sa.name
      storage_account_key  = azurerm_storage_account.aci_sa.primary_access_key
    }
  }

  tags = {
    environment = "testing"
  }

  ip_address_type = "Public"
  dns_name_label  = "overpassapi"
}

# Outputs
output "container_ip_address" {
  value       = azurerm_container_group.aci_container.ip_address
  description = "The IP address of the Azure Container Instance"
}
