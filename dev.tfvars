resource_group_name     = "dev-rg"
resource_group_location = "eastus"
app_service_plan_name   = "dev-appserviceplan"
app_service_name        = "dev-appservice"
mssql_server_name       = "dev-sqlserver"
mssql_database_name     = "DevDB"
mssql_admin_login       = "userdev"
mssql_admin_password    = "@Aa123456789!"
tags = {
  terraformDeployment = "true",
  Environment         = "DEV"
}

database_config = {
  name           = "stag-db"
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true
}