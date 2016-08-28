# Docker Hub Webhook

This project currently simply listen to a POST endpoint and try to deploy the Docker Hub project on the configured
Amazon ECS.

In order for this app to work you must configure the following environment variables:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN (optional)
REGION
CLUSTER
SERVICE
CONTAINER