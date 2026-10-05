/*
  Input Variables - Databricks Service Principals Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/variables

  Defines the schema and validation rules for account-level Databricks service principals.
*/

variable "service_principals" {
  description = "Map of service principals to create. The map key is a stable logical identifier used for references from other modules."
  type = map(object({
    display_name = string
    active       = optional(bool, true)
    external_id  = optional(string)
  }))
  default = {}

  validation {
    condition     = alltrue([for sp in values(var.service_principals) : length(trimspace(sp.display_name)) > 0])
    error_message = "Every service principal display_name must be a non-empty string."
  }

  validation {
    condition     = length(distinct([for sp in values(var.service_principals) : sp.display_name])) == length(var.service_principals)
    error_message = "Service principal display_name values must be unique."
  }
}
