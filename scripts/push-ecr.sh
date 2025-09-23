#!/usr/bin/env bash
set -euo pipefail

AWS_REGION="us-east-1"
ECR_REPO="demo-web"
IMAGE_TAG="v1"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_URI="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"

echo "Creating ECR repo if missing: ${ECR_REPO}"
aws ecr describe-repositories --repository-names "${ECR_REPO}" --region "${AWS_REGION}" >/dev/null 2>&1 || \
aws ecr create-repository --repository-name "${ECR_REPO}" --region "${AWS_REGION}"

echo "Logging in to ECR…"
aws ecr get-login-password --region "${AWS_REGION}" \
| docker login --username AWS --password-stdin "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "Building image…"
docker build -t "${ECR_URI}:${IMAGE_TAG}" ./app

echo "Pushing image…"
docker push "${ECR_URI}:${IMAGE_TAG}"

echo "Done."
echo "IMAGE_URI=${ECR_URI}"
echo "IMAGE_TAG=${IMAGE_TAG}"
