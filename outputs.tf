output "gke_cluster_name" {
  value       = module.gke.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "gke_cluster_host" {
  value       = module.gke.kubernetes_cluster_host
  description = "GKE Cluster Host"
}

output "cloud_sql_instance_name" {
  value       = module.cloud_sql.instance_name
  description = "Cloud SQL Instance Name"
}

output "cloud_sql_connection_name" {
  value       = module.cloud_sql.instance_connection_name
  description = "Cloud SQL Instance Connection Name"
}

output "gcs_bucket_name" {
  value       = module.gcs.bucket_name
  description = "GCS Bucket Name"
}

output "nginx_service_ip" {
  value       = module.gke.load_balancer_ip
  description = "External IP address of the Nginx service"
}