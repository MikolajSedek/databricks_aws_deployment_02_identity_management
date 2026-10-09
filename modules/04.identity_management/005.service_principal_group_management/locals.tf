/*
  Local Values and Rule Set Construction - Service Principal Group Management Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/locals

  Builds authoritative grant rules, resolves group ACL principal strings, and
  constructs full resource names for service principal default rule sets.
*/

locals {
  /*
    Build grant rules for each service principal by resolving group keys to principals in one pass.
    Managers and users are combined into a single rule list per SP.
  */
  grant_rules = {
    for sp_key, grants in var.service_principal_group_roles : sp_key =>
    concat(
      length(grants.managers) > 0 ? [{
        role       = "roles/servicePrincipal.manager"
        principals = [for g in grants.managers : lookup(var.group_acl_principal_ids, g, null)]
      }] : [],
      length(grants.users) > 0 ? [{
        role       = "roles/servicePrincipal.user"
        principals = [for g in grants.users : lookup(var.group_acl_principal_ids, g, null)]
      }] : []
    )
  }

  // resource name of the default rule set of each service principal; "" for unknown keys (reported by preconditions)
  rule_set_names = {
    for sp_key, grants in var.service_principal_group_roles :
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
