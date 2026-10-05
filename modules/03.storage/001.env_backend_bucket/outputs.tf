/*
  Output Values - S3 Backend Bucket Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/outputs

  Exports the S3 bucket ID, ARN, and domain name for remote state configuration.
*/

output "bucket_id" {
  description = "The ID / name of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.this.bucket_domain_name
}
