data "google_sql_database_instance" "instance" {
  name = element(split(":", var.sql_connection_name), 2)
}

resource "kubernetes_config_map" "nginx_config" {
  metadata {
    name = "nginx-config"
  }

  data = {
    "index.html" = <<-EOF
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Welcome to Our Nginx Web Application</title>
          <style>
              body {
                  font-family: Arial, sans-serif;
                  line-height: 1.6;
                  color: #333;
                  max-width: 800px;
                  margin: 0 auto;
                  padding: 20px;
              }
              h1 {
                  color: #2c3e50;
              }
          </style>
      </head>
      <body>
          <h1>Welcome to Nginx Web Application</h1>
          <p>This is a simple website served by the default Nginx image running in Google Kubernetes Engine (GKE).</p>
          <p>Application infrastructure includes:</p>
          <ul>
              <li>Nginx web server running in Google Kubernetes Engine (GKE)</li>
              <li>Cloud SQL for our MySQL database</li>
              <li>Google Cloud Storage (GCS) for hosting static content</li>
          </ul>
          <p>SQL Connection Address: ${data.google_sql_database_instance.instance.public_ip_address}:3306</p>
          <p>GCS Bucket URL: ${var.gcs_bucket_url}</p>
          <p>This infrastructure was set up using Terraform</p>
      </body>
      </html>
    EOF
  }
}


resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx-deployment"
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"

          port {
            container_port = 80
          }

          volume_mount {
            name       = "nginx-config"
            mount_path = "/usr/share/nginx/html/index.html"
            sub_path   = "index.html"
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }

        volume {
          name = "nginx-config"
          config_map {
            name = kubernetes_config_map.nginx_config.metadata[0].name
          }
        }
      }
    }
  }

  timeouts {
    create = "15m"
    update = "15m"
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment.nginx.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}