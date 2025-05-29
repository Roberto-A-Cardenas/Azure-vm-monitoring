variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID (App ID)"
}

variable "client_secret" {
  type        = string
  sensitive   = true
  description = "Azure Client Secret (Password)"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}
