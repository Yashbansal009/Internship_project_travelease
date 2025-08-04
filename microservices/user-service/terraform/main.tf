# Terraform configuration for user-service
provider "aws" {
  region = "ap-south-1" # REQUIRED: Change if deploying to another region
}

resource "aws_ecr_repository" "user" {
  name = "travelease1/user" # REQUIRED: Ensure this matches your ECR repo
}

# REQUIRED: Add ECS cluster, task definition, and service resources as needed
# Terraform for User Service
# Define AWS resources for ECS/EC2, ALB/NLB, Cloud Map, IAM, ECR
