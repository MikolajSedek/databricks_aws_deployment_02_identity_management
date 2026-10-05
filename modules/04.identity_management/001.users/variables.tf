/*
  Input Variables - Databricks Users Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/variables

  Defines the schema and validation rules for creating account-level Databricks users.
*/

variable "users" {
  description = "Map of users to create. The map key is a stable logical identifier used for references from other modules; user_name is the user's email address."
  type = map(object({
    user_name    = string
    display_name = optional(string)
    active       = optional(bool, true)
    external_id  = optional(string)
  }))
  default = {}

  validation {
    condition     = alltrue([for u in values(var.users) : can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", u.user_name))])
    error_message = "Every user_name must be a valid email address."
  }

  validation {
    condition     = length(distinct([for u in values(var.users) : lower(u.user_name)])) == length(var.users)
    error_message = "user_name values must be unique (case-insensitive)."
  }
}
