# Overview

Deploy a PHP-FPM app on Cloud Run with a Cloud SQL (MySQL) database using Terraform.

# Prerequisites

- Google Cloud SDK installed and authenticated
- Docker installed
- Terraform installed (v1.x recommended)
- A GCP project with billing enabled

# Resources Created

- Cloud SQL (MySQL) instance with mydb database and admin user
- Cloud Run service running PHP-FPM
- Service account with roles/cloudsql.client for Cloud Run
- Cloud Storage bucket for static files (optional)

# Variables

- project_id - GCP project ID
- region - GCP region for resources
- db_name - MySQL database name
- db_user - MySQL user
- db_password - MySQL password
- static_bucket_name - Cloud Storage bucket name

# Steps

- Authenticate and set project:
```
gcloud auth login
gcloud config set project PROJECT_ID
```
- Build Docker image for PHP-FPM app:
```
docker build -t gcr.io/${PROJECT_ID}/php-app:latest .
```

- Push Docker image to Google Container Registry:
```
docker push gcr.io/${PROJECT_ID}/php-app:latest
```

- Initialize Terraform:
```
terraform init
```

- Plan Terraform:
```
terraform plan
```

- Apply Terraform:
```
terraform apply
```

- Visit the Cloud Run URL – you should see:
```
Connected to database successfully!
```

# Notes
- Cloud Run connects to Cloud SQL via the CLOUD_SQL_CONNECTION_NAME annotation.
- Environment variables (DB_HOST, DB_NAME, DB_USER, DB_PASSWORD) are passed to the container.
- The service account used by Cloud Run must have roles/cloudsql.client.
