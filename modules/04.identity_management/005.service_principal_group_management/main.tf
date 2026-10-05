/*
  Databricks Service Principal Group-Level Management
  Documentation: https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/access_control_rule_set

  Grants groups a role on a service principal (roles/servicePrincipal.manager or
  roles/servicePrincipal.user) by managing one account-level rule set per service principal.
  NOTE: the rule set is authoritative and overwrites existing grants on the service principal.
*/

resource "databricks_access_control_rule_set" "this" {
  for_each = var.service_principal_group_roles

  // accounts/<account_id>/servicePrincipals/<application_id>/ruleSets/default
  name = local.rule_set_names[each.key]

  // one grant_rules block per role that has at least one group
  dynamic "grant_rules" {
    for_each = local.grant_rules[each.key]

    content {
      role       = grant_rules.value.role
      principals = grant_rules.value.principals
    }
  }

  // plan-time referential integrity checks; messages list the offending keys
  lifecycle {
    precondition {
      condition     = length(local.unknown_service_principal_keys) == 0
      error_message = "Unknown service principal keys (missing in service_principal_application_ids): ${join(", ", local.unknown_service_principal_keys)}."
    }
    precondition {
      condition     = length(local.unknown_group_keys) == 0
      error_message = "Unknown group keys (missing in group_acl_principal_ids): ${join(", ", local.unknown_group_keys)}."
    }
  }
}
