variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "resource_group_location" {
  type        = string
  description = "RG location in Azure"
}

variable "app_service_plan_name" {
  type        = string
  description = "App Service Plan name in Azure"
}

variable "app_service_name" {
  type        = string
  description = "App Service name in Azure"
}

variable "mssql_server_name" {
  type        = string
  description = "MSSQL Server instance name in Azure"
}

variable "mssql_database_name" {
  type        = string
  description = "MSSQL Database name in Azure"
}

variable "mssql_admin_login" {
  type        = string
  description = "MSSQL Server login name in Azure"
}

variable "mssql_admin_password" {
  type        = string
  description = "MSSQL Server password name in Azure"
}

variable "tags" {
  type        = map(any)
  description = "Specifies a map of tags to be applied to the resources created."
}

variable "database_config" {
  type = object({
    name           = string
    collation      = string
    license_type   = string
    max_size_gb    = number
    read_scale     = bool
    sku_name       = string
    zone_redundant = bool
  })
  description = "Specifies a object of dbconfig to be applied to the resources created."
}