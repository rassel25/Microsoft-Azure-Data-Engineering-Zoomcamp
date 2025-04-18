variable "prefix" {
  description = "Common prefix for all resources"
  default     = "dtcdezca"
}

variable "location" {
  description = "Resource group location"
  default     = "eastus"
}

variable "mssql_server_admin_username" {
  type        = string
  default     = "rickyadmin"
}

variable "db_admin_username" {
  type        = string
  description = "Administrator login for the MSSQL server"
  default     = "rickyadmin"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  default     = null
}
