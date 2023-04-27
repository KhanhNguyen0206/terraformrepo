terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
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

resource "azurerm_service_plan" "lab-asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.lab-rg.location
  resource_group_name = azurerm_resource_group.lab-rg.name
  tags                = var.tags
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "app" {
  name                = var.web_app_name
  resource_group_name = azurerm_resource_group.lab-rg.name
  location            = azurerm_resource_group.lab-rg.location
  service_plan_id     = azurerm_service_plan.lab-asp.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = "Server=tcp:azurerm_mssql_server.sql.fully_qualified_domain_name Database=azurerm_mssql_database.db.name;User ID=azurerm_mssql_server.sql.administrator_login;Password=azurerm_mssql_server.sql.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  }
}
resource "azurerm_mssql_server" "lab-mss" {
  name                         = var.mssql_server_name
  resource_group_name          = azurerm_resource_group.lab-rg.name
  location                     = azurerm_resource_group.lab-rg.location
  version                      = var.mssql_version
  administrator_login          = var.mssql_admin_login
  administrator_login_password = var.mssql_admin_password
}

resource "azurerm_mssql_database" "db" {
  name           = var.mssql_database_name
  server_id      = azurerm_mssql_server.lab-mss.id
  collation      = var.database_config.collation
  license_type   = var.database_config.license_type
  storage_mb     = var.database_config.storage_mb
  read_scale     = var.database_config.read_scale
  sku_name       = var.database_config.sku_name
  zone_redundant = var.database_config.zone_redundant
}

resource "azurerm_storage_account" "lab-sta" {
  count                     = length(var.storage_config)
  name                      = var.storage_account
  resource_group_name       = azurerm_resource_group.lab-rg.name
  location                  = azurerm_resource_group.lab-rg.location
  account_kind              = var.storage_config[count.index].account_kind
  account_tier              = var.storage_config[count.index].account_tier
  account_replication_type  = var.storage_config[count.index].account_replication_type
  access_tier               = var.storage_config[count.index].access_tier
  enable_https_traffic_only = var.storage_config[count.index].enable_https_traffic_only
  min_tls_version           = var.storage_config[count.index].min_tls_version
  is_hns_enabled            = var.storage_config[count.index].is_hns_enabled
}
