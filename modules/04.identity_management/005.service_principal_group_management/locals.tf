/*
  Local Values and Rule Set Construction - Service Principal Group Management Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/locals

  Builds authoritative grant rules, resolves group ACL principal strings, and
  constructs full resource names for service principal default rule sets.
*/

locals {
  /*
    Resolve manager group keys to ACL principal IDs for each service principal.
  */
  sp_manager_principals = {
    for sp_key, grants in var.service_principal_group_roles : sp_key =>
      [for g in grants.managers : lookup(var.group_acl_principal_ids, g, null)]
  }

  /*
    Resolve user group keys to ACL principal IDs for each service principal.
  */
  sp_user_principals = {
    for sp_key, grants in var.service_principal_group_roles : sp_key =>
      [for g in grants.users : lookup(var.group_acl_principal_ids, g, null)]
  }

  /*
    Build manager rule object for each SP, or null if no managers.
  */
  manager_rules = {
    for sp_key, grants in var.service_principal_group_roles : sp_key =>
      length(grants.managers) > 0 ? {
        role       = "roles/servicePrincipal.manager"
        principals = local.sp_manager_principals[sp_key]
      } : null
  }

  /*
    Build user rule object for each SP, or null if no users.
  */
  user_rules = {
    for sp_key, grants in var.service_principal_group_roles : sp_key =>
      length(grants.users) > 0 ? {
        role       = "roles/servicePrincipal.user"
        principals = local.sp_user_principals[sp_key]
      } : null
  }

  /*
    Combine manager and user rules, filtering out nulls.
  */
  grant_rules = {
    for sp_key in keys(var.service_principal_group_roles) : sp_key =>
      [for rule in [local.manager_rules[sp_key], local.user_rules[sp_key]] : rule if rule != null]
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
