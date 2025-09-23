# EKS + CodePipeline (kubectl) — raw Kubernetes manifests

This repo demonstrates how to deploy raw Kubernetes manifests to Amazon EKS using CodePipeline v2.

## Structure
- `app/` → sample nginx app + Dockerfile
- `k8s/manifest.yaml` → namespace, deployment, service
- `scripts/push-ecr.sh` → helper to push image to ECR
- `iam/pipeline-eks-deploy.json` → IAM policy for CodePipeline role

## Usage
1. Build & push the sample image:
   ```bash
   ./scripts/push-ecr.sh
