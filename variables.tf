variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "ml-platform-rg"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "eastus"
}

variable "storage_account_name" {
  description = "Globally unique name for the storage account"
  type        = string
}

variable "key_vault_name" {
  description = "Globally unique name for the key vault"
  type        = string
}

variable "workspace_name" {
  description = "Name of the Azure Machine Learning workspace"
  type        = string
  default     = "ml-platform-workspace"
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}
