output "bucket_name" {
  description = "GCS Bucket Name"
  value       = google_storage_bucket.actual_bucket.name
}

output "ci_sa_email" {
  description = "CI Service Account Email"
  value       = google_service_account.ci_sa.email
}

output "ci_sa_key" {
  description = "CI Service Account Key"
  value       = google_service_account_key.ci_sa_key.private_key
  sensitive   = true
}
