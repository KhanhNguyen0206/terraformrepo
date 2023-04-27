resource_group_name     = "stag-rg"
resource_group_location = "eastus"
app_service_plan_name   = "stag-appserviceplan"
app_service_name        = "stag-appservice"
mssql_server_name         = "stag-sqlserver"
mssql_database_name       = "StagDB"
mssql_admin_login         = "userstag"
mssql_admin_password      = "@Aa123456789!"
tags = {
  terraformDeployment = "true",
  Environment         = "STG"
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