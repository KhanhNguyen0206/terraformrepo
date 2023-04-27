resource_group_name     = "dev-rg"
resource_group_location = "eastus"
web_app_name            = "terraformlabapp"
storage_account         = "labterraformstaccount1"
app_service_plan_name   = "dev-appserviceplan"
app_service_name        = "dev-appservice"
mssql_server_name       = "dev-terraformlabsqlserver"
mssql_database_name     = "DevDB"
mssql_admin_login       = "userdev"
mssql_admin_password    = "@Aa123456789!"
mssql_version           = "12.0"
tags = {
  terraformDeployment = "true",
  Environment         = "DEV"
}

database_config = {
  name                  = "stag-db"
  collation             = "SQL_Latin1_General_CP1_CI_AS"
  license_type          = "LicenseIncluded"
  max_size_gb           = 1
  read_scale            = true
  sku_name              = "S0"
  storage_account_type  = "GRS"
}

storage_config = [
  {
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    min_tls_version           = "TLS1_2"
    enable_https_traffic_only = true
    access_tier               = "Cool"
    is_hns_enabled            = false
  },
  {
    account_kind              = "BlockBlobStorage"
    account_tier              = "Premium"
    account_replication_type  = "ZRS"
    min_tls_version           = "TLS1_2"
    enable_https_traffic_only = false
    access_tier               = "Hot"
    is_hns_enabled            = true
  }
]