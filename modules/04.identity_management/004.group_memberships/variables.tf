/*
  Input Variables - Databricks Group Memberships Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/variables

  Defines inputs for group IDs, principal IDs, and composite membership definitions.
*/

variable "group_ids" {
  description = "Map of group key => group ID (output of the groups module)."
  type        = map(string)
}

variable "user_ids" {
  description = "Map of user key => user ID (output of the users module)."
  type        = map(string)
  default     = {}
}

variable "service_principal_ids" {
  description = "Map of service principal key => ID (output of the service principals module)."
  type        = map(string)
  default     = {}
}

variable "group_memberships" {
  description = "Map of group key => members, expressed as lists of user, service principal and nested group keys."
  type = map(object({
    users              = optional(list(string), [])
    service_principals = optional(list(string), [])
    groups             = optional(list(string), [])
  }))
  default = {}
}
