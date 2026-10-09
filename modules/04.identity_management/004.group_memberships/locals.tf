/*
  Local Values and Membership Flattening - Databricks Group Memberships Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/locals

  Flattens composite group membership maps into discrete member tuples and calculates
  referential integrity validation sets.
*/

locals {
  /*
    Flatten group_memberships (group key => member key lists) into one list per member type.
    Every entry gets a stable id "<group>/<type>/<member>" used as the for_each key, and the
    member ID resolved from the matching ID map. lookup() returns null for unknown keys so
    the preconditions in main.tf can report them instead of failing with an index error.
  */
  user_memberships = flatten([
    for group_key, m in var.group_memberships : [
      for key in m.users : { id = "${group_key}/user/${key}", group_key = group_key, member_id = lookup(var.user_ids, key, null) }
    ]
  ])

  service_principal_memberships = flatten([
    for group_key, m in var.group_memberships : [
      for key in m.service_principals : { id = "${group_key}/service_principal/${key}", group_key = group_key, member_id = lookup(var.service_principal_ids, key, null) }
    ]
  ])

  nested_group_memberships = flatten([
    for group_key, m in var.group_memberships : [
      for key in m.groups : { id = "${group_key}/group/${key}", group_key = group_key, member_id = lookup(var.group_ids, key, null) }
    ]
  ])

  // all membership entries regardless of member type
  all_memberships = concat(local.user_memberships, local.service_principal_memberships, local.nested_group_memberships)

  // final for_each map consumed by databricks_group_member.this
  memberships = {
    for m in local.all_memberships : m.id => {
      group_id  = lookup(var.group_ids, m.group_key, null)
      member_id = m.member_id
    }
  }

  // every key referenced by var.group_memberships, per kind
  referenced_group_keys = toset(concat(keys(var.group_memberships), flatten(values(var.group_memberships)[*].groups)))
  referenced_user_keys  = toset(flatten(values(var.group_memberships)[*].users))
  referenced_sp_keys    = toset(flatten(values(var.group_memberships)[*].service_principals))

  // referenced keys missing from the supplied ID maps (reported by preconditions in main.tf)
  unknown_group_keys             = setsubtract(local.referenced_group_keys, keys(var.group_ids))
  unknown_user_keys              = setsubtract(local.referenced_user_keys, keys(var.user_ids))
  unknown_service_principal_keys = setsubtract(local.referenced_sp_keys, keys(var.service_principal_ids))

  // groups listing themselves as a member (not allowed)
  self_referencing_groups = [for g, m in var.group_memberships : g if contains(m.groups, g)]
}
