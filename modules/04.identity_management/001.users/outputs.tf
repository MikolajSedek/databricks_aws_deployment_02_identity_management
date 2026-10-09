/*
  Output Values - Databricks Users Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/outputs

  Exports map of user keys to Databricks user IDs.
*/

output "ids" {
  description = "Map of user key => Databricks user ID."
  value       = { for k, u in databricks_user.this : k => u.id }
}
