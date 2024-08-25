provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.kubernetes_cluster_host}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.kubernetes_cluster_ca_certificate)
}

module "gke" {
  source              = "./modules/gke"
  project_id          = var.project_id
  region              = var.region
  sql_connection_name = module.cloud_sql.instance_connection_name
  gcs_bucket_url      = module.gcs.bucket_url
}

module "cloud_sql" {
  source      = "./modules/cloud_sql"
  project_id  = var.project_id
  region      = var.region
  db_password = var.db_password
}

module "gcs" {
  source     = "./modules/gcs"
  project_id = var.project_id
  region     = var.region
}