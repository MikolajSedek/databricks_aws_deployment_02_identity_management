/*
  Input Variables - Service Principal Group Management Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/variables

  Defines account ID, application IDs, group ACL principals, and role assignments.
*/

variable "account_id" {
  description = "Databricks account ID (UUID)."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.account_id))
    error_message = "account_id must be a valid UUID."
  }
}

variable "service_principal_application_ids" {
  description = "Map of service principal key => application ID (output of the service principals module)."
  type        = map(string)
}

variable "group_acl_principal_ids" {
  description = "Map of group key => ACL principal ID (output of the groups module)."
  type        = map(string)
}

variable "service_principal_group_roles" {
  description = "Map of service principal key => groups granted roles/servicePrincipal.manager (managers) and roles/servicePrincipal.user (users), as lists of group keys."
  type = map(object({
    managers = optional(list(string), [])
    users    = optional(list(string), [])
  }))
  default = {}
}
