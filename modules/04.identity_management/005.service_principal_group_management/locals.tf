/*
  Local Values and Rule Set Construction - Service Principal Group Management Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/locals

  Builds authoritative grant rules, resolves group ACL principal strings, and
  constructs full resource names for service principal default rule sets.
*/

locals {
  /*
    Grant rules per service principal: one rule per role, skipped when no group holds the role.
    Group keys are translated to ACL principal IDs ("groups/<display_name>").
  */
  grant_rules = {
    for sp_key, grants in var.service_principal_group_roles : sp_key => [
      for rule in [
        { role = "roles/servicePrincipal.manager", group_keys = grants.managers },
        { role = "roles/servicePrincipal.user", group_keys = grants.users },
      ] : { role = rule.role, principals = [for g in rule.group_keys : lookup(var.group_acl_principal_ids, g, null)] }
      if length(rule.group_keys) > 0
    ]
  }

  // resource name of the default rule set of each service principal; "" for unknown keys (reported by preconditions)
  rule_set_names = {
    for sp_key in keys(var.service_principal_group_roles) :
    sp_key => "accounts/${var.account_id}/servicePrincipals/${lookup(var.service_principal_application_ids, sp_key, "")}/ruleSets/default"
  }

  // every group key referenced as manager or user
  referenced_group_keys = toset(concat(
    flatten(values(var.service_principal_group_roles)[*].managers),
    flatten(values(var.service_principal_group_roles)[*].users),
  ))

  // referenced keys missing from the supplied ID maps (reported by preconditions in main.tf)
  unknown_service_principal_keys = setsubtract(keys(var.service_principal_group_roles), keys(var.service_principal_application_ids))
  unknown_group_keys             = setsubtract(local.referenced_group_keys, keys(var.group_acl_principal_ids))
}
