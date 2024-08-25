output "bucket_name" {
  value       = google_storage_bucket.my-bucket.name
  description = "The name of the GCS bucket"
}

output "bucket_url" {
  value       = google_storage_bucket.my-bucket.url
  description = "The URL of the GCS bucket"
}