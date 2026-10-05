/*
  Terraform and Databricks Provider Configuration - Service Principal Group Management Module
  Documentation: https://registry.terraform.io/providers/databricks/databricks/latest/docs

  Declares required Terraform binary version and Databricks provider constraints.
*/

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.135.0"
    }
  }
}
