terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_sql_database_instance" "mysql" {
  name             = "my-sql-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    backup_configuration {
      enabled = false
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "db" {
  name     = var.db_name
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "root" {
  name     = var.db_user
  instance = google_sql_database_instance.mysql.name
  password = var.db_password
}

resource "google_cloud_run_service" "php_app" {
  name     = "php-app"
  location = var.region
  project  = var.project_id

  template {
    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.mysql.connection_name
      }
    }
    spec{

      service_account_name = "my-service-account@${var.project_id}.iam.gserviceaccount.com"

      containers {
        image = "gcr.io/${var.project_id}/php-app:latest"

        env {
          name  = "DB_HOST"
          value = "127.0.0.1"
        }
        env {
          name  = "DB_NAME"
          value = var.db_name
        }
        env {
          name  = "DB_USER"
          value = var.db_user
        }
        env {
          name  = "DB_PASSWORD"
          value = var.db_password
        }
        env {
          name  = "CLOUD_SQL_CONNECTION_NAME"
          value = google_sql_database_instance.mysql.connection_name
	}
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_project" "project" {}

