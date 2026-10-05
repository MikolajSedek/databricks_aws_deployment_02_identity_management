/*
  Output Values - Databricks Group Memberships Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/outputs

  Exports mapped membership resource identifiers for auditability and verification.
*/

output "membership_ids" {
  description = "Map of membership key (<group>/<type>/<member>) => group member resource ID."
  value       = { for k, m in databricks_group_member.this : k => m.id }
}
