resource "google_sql_database_instance" "mysql" {
  name             = "mysql-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "all"
        value = "0.0.0.0/0"
      }
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "users" {
  name     = "my-user"
  instance = google_sql_database_instance.mysql.name
  password = var.db_password
}