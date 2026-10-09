/*
  Output Values - Databricks Groups Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/outputs

  Exports maps of group keys to group IDs and ACL principal IDs,
  guaranteeing completion of admin role attachments before downstream consumption.
*/

output "ids" {
  description = "Map of group key => Databricks group ID."
  value       = { for k, g in databricks_group.this : k => g.id }
  depends_on  = [databricks_group_role.account_admin]
}

output "acl_principal_ids" {
  description = "Map of group key => ACL principal ID (groups/<display_name>) used in access control rule sets."
  value       = { for k, g in databricks_group.this : k => g.acl_principal_id }
  depends_on  = [databricks_group_role.account_admin]
}
