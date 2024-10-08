resource "google_storage_bucket" "my-bucket" {
  name          = "${var.project_id}-my-bucket"
  location      = var.region
  force_destroy = true
  uniform_bucket_level_access = true
}