output "bucket_name" {
  description = "GCS Bucket Name"
  value       = google_storage_bucket.actual_bucket.name
}

output "base64_encoded_service_account_json" {
  description = "Base64-encoded service account key JSON"
  value       = google_service_account_key.ci_sa_key.private_key
  sensitive   = true
}
