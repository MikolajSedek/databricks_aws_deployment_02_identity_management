/*
  Output Values - Databricks Users Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/outputs

  Exports maps of user keys to Databricks user IDs and usernames (email addresses).
*/

output "ids" {
  description = "Map of user key => Databricks user ID."
  value       = { for k, u in databricks_user.this : k => u.id }
}

output "user_names" {
  description = "Map of user key => user name (email)."
  value       = { for k, u in databricks_user.this : k => u.user_name }
}
