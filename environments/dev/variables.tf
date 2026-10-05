/*
  Input Variables Definition - Dev Environment
  Documentation:
    - https://developer.hashicorp.com/terraform/language/values/variables

  Declares configuration variables for the dev environment:
    - Target AWS deployment settings (region, account ID, profile, environment).
    - Databricks account credentials (account ID, OAuth client ID, and sensitive client secret).
    - Target user email addresses for provisioning account users.
*/

variable "aws_region" {
  description = "The AWS region where resources will be deployed."
  type        = string
  default     = "eu-central-1"

  validation {
    condition     = can(regex("^[a-z]{2}(-[a-z]+)+-\\d$", var.aws_region))
    error_message = "The AWS region must be a valid region format (e.g. eu-central-1, us-east-1)."
  }
}

variable "aws_account_id" {
  description = "The allowed AWS Account ID to prevent accidental deployment to the wrong account."
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "The AWS Account ID must be a 12-digit number."
  }
}

variable "environment" {
  description = "Deployment environment name (e.g. dev, staging, prod)."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod", "test"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, test."
  }
}

variable "profile" {
  description = "AWS CLI user profile"
  type        = string
  default     = "default"
}

variable "service_principal_id" {
  description = "The service principal ID for the Databricks workspace / account"
  type        = string
}

variable "service_principal_secret" {
  description = "The service principal secret for the Databricks workspace / account"
  type        = string
  sensitive   = true
}

variable "databricks_account_id" {
  description = "The Databricks account ID (UUID) used by the account-level provider."
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.databricks_account_id))
    error_message = "The Databricks account ID must be a valid UUID."
  }
}

variable "user1_email" {
  description = "Email address of the first user to be created in Databricks."
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.user1_email))
    error_message = "The user1_email must be a valid email address."
  }
}

variable "user2_email" {
  description = "Email address of the second user to be created in Databricks."
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.user2_email))
    error_message = "The user2_email must be a valid email address."
  }
}
