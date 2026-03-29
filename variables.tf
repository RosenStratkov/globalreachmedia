variable "project_id" {
  description = "GCP project ID"
  default     = "project-48d23e34-31d5-4d55-91d"
}

variable "region" {
  description = "GCP region for resources"
  default     = "europe-west1"
}

variable "db_name" {
  description = "The name of the MySQL database"
  default     = "mydb"
}

variable "db_user" {
  description = "The MySQL root user"
  default     = "admin"
}

variable "db_password" {
  description = "The MySQL root password"
  default     = "PaSStest!123"
}
