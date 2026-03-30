#!/bin/bash
SERVICE_NAME=${1:-php-app}
REGION=${2:-europe-west1}

URL=$(gcloud run services describe $SERVICE_NAME \
      --region $REGION \
      --format 'value(status.url)')

if [ -z "$URL" ]; then
  echo "Could not retrieve Cloud Run URL"
  exit 1
fi

echo "Cloud Run URL: $URL"
