/*
  Terraform, AWS, and Databricks Provider Configuration - Dev Environment
  Documentation:
    - https://registry.terraform.io/providers/hashicorp/aws/latest/docs
    - https://registry.terraform.io/providers/databricks/databricks/latest/docs

  Configures required provider plugins and authentication for the dev environment:
    - AWS provider: Region, CLI profile, and default resource tags.
    - Databricks provider (mws alias): Account-level authentication using OAuth M2M
      service principal credentials against the Databricks Account console.
*/

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.66.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.135.0"
    }

  }
}

provider "aws" {
  profile             = var.profile
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "DatabricksDeployment"
    }
  }
}

provider "databricks" {
  alias         = "mws"
  host          = "https://accounts.cloud.databricks.com"
  account_id    = var.databricks_account_id
  client_id     = var.service_principal_id
  client_secret = var.service_principal_secret
}
