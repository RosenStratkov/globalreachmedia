# Overview

Deploy a PHP-FPM app on Cloud Run with a Cloud SQL (MySQL) database using Terraform.
First is the manual process, GitHub automated process follows below.

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

# GitHub Actions Deployment

- Checkout repository – pulls your code into the runner.
- Authenticate to Google Cloud – uses a service account stored in GCP_SA_KEY.
- Set up gcloud SDK – ensures the runner can use Google Cloud commands.
- Docker authentication – allows pushing images to Google Container Registry.
- Build Docker image – packages your PHP-FPM app.
- Push Docker image – uploads the image to GCR.
- Deploy to Cloud Run – deploys the container to the specified project and region, connects to the Cloud SQL instance, sets environment variables, and makes the service publicly accessible (--allow-unauthenticated).
- Retrieve Cloud Run URL – prints the public URL of your service.

# Secrets used

- GCP_SA_KEY – JSON key for the GCP service account with Cloud Run and Cloud SQL permissions.
- GCP_PROJECT_ID – ID of the target Google Cloud project.
- DB_PASSWORD – MySQL password for Cloud SQL, injected as an environment variable.

After the workflow runs your Cloud Run service is live, publicly accessible, and connected to the Cloud SQL database.

# Shell script to get url

- Can be found in the repo called 'get-url.sh' and executed like
  ```./get-url.sh```

- The url is outputted in the last step of the GitHub Action. Clicking it you should see
  ```Connected to database successfully!```
