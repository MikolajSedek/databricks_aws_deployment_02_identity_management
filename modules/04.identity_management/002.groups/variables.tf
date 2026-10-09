/*
  Input Variables - Databricks Groups Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/variables

  Defines the schema and validation constraints for account-level Databricks groups.
*/

variable "groups" {
  description = "Map of groups to create. The map key is a stable logical identifier used for references from other modules."
  type = map(object({
    display_name  = string
    external_id   = optional(string)
    force         = optional(bool, false)
    account_admin = optional(bool, false)
  }))
  default = {}

  validation {
    condition     = alltrue([for g in values(var.groups) : length(trimspace(g.display_name)) > 0])
    error_message = "Every group display_name must be a non-empty string."
  }

  validation {
    condition     = length(distinct([for g in values(var.groups) : g.display_name])) == length(var.groups)
    error_message = "Group display_name values must be unique."
  }
}
