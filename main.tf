terraform {
  required_providers {
    azurerm ={
        source = "hashicorp/azurerm"
        version = "=3.0.0"
    }
  }
}
terraform {
  backend "azurerm" {
    resource_group_name  = "terraformlab"
    storage_account_name = "terraformstoragelab"
    container_name       = "tfstoragecontainer"
    key                  = "tfstoragecontainer.tfstate"
  }
}
provider "azurerm" {
  features {
    
  }
}
resource "azurerm_resource_group" "lab-rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.tags
}

resource "azurerm_app_service_plan" "lab-asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.lab-rg.name
  resource_group_name = azurerm_resource_group.lab-rg.location
  tags                = var.tags
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "lab-asv" {
  name                = var.app_service_name
  location            = azurerm_resource_group.lab-rg.location
  resource_group_name = azurerm_resource_group.lab-rg.name
  app_service_plan_id = azurerm_app_service_plan.lab-asp.id
  tags                = var.tags
  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}

resource "azurerm_storage_account" "lab-sta" {
  name                     = "labstaccount"
  resource_group_name      = azurerm_resource_group.lab-rg.name
  location                 = azurerm_resource_group.lab-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "lab-mss" {
  name                         = var.mssql_server_name
  resource_group_name      = azurerm_resource_group.lab-rg.name
  location                 = azurerm_resource_group.lab-rg.location
  version                      = "12.0"
  administrator_login          = var.mssql_admin_login
  administrator_login_password = var.mssql_admin_password
}

resource "azurerm_mssql_database" "lab-db" {
  name           = var.mssql_database_name
  server_id      = azurerm_mssql_server.lab-mss.id
  collation      = var.database_config.collation
  license_type   = var.database_config.license_type
  max_size_gb    = var.database_config.max_size_gb
  read_scale     = var.database_config.read_scale
  sku_name       = var.database_config.sku_name
  zone_redundant = var.database_config.zone_redundant
}