resource_group_name     = "stag-rg"
resource_group_location = "eastus"
web_app_name            = "terraformlabapp"
storage_account         = "labterraformstaccount2"
app_service_plan_name   = "stag-appserviceplan"
app_service_name        = "stag-appservice"
mssql_server_name       = "stag-sqlserver"
mssql_database_name     = "StagDB"
mssql_admin_login       = "userstag"
mssql_admin_password    = "@Aa123456789!"
mssql_version           = "12.0"
tags = {
  terraformDeployment = "true",
  Environment         = "STG"
}
database_config = {
  name                  = "stag-db"
  collation             = "SQL_Latin1_General_CP1_CI_AS"
  license_type          = "LicenseIncluded"
  max_size_gb           = 1
  sku_name              = "BC_Gen5_2"
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