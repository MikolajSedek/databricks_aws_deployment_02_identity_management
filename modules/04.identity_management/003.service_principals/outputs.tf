/*
  Output Values - Databricks Service Principals Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/outputs

  Exports maps of service principal keys to IDs, application (client) IDs, and ACL principal IDs.
*/

output "ids" {
  description = "Map of service principal key => Databricks service principal ID."
  value       = { for k, sp in databricks_service_principal.this : k => sp.id }
  depends_on  = [databricks_service_principal.this]
}

output "application_ids" {
  description = "Map of service principal key => application (client) ID."
  value       = { for k, sp in databricks_service_principal.this : k => sp.application_id }
  depends_on  = [databricks_service_principal.this]
}

output "acl_principal_ids" {
  description = "Map of service principal key => ACL principal ID (servicePrincipals/<application_id>)."
  value       = { for k, sp in databricks_service_principal.this : k => sp.acl_principal_id }
  depends_on  = [databricks_service_principal.this]
}
