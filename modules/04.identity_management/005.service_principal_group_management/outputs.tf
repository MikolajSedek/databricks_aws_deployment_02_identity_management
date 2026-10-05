/*
  Output Values - Service Principal Group Management Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/outputs

  Exports identifiers of configured access control rule sets.
*/

output "rule_set_ids" {
  description = "Map of service principal key => access control rule set ID."
  value       = { for k, r in databricks_access_control_rule_set.this : k => r.id }
}
