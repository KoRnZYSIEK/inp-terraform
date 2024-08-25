output "instance_name" {
  value       = google_sql_database_instance.mysql.name
  description = "The name of the Cloud SQL instance"
}

output "instance_connection_name" {
  value       = google_sql_database_instance.mysql.connection_name
  description = "The connection name of the Cloud SQL instance"
}