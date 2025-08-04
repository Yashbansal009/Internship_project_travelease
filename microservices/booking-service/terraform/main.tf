# Terraform configuration for booking-service
provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "booking" {
  name = "travelease1/booking"
}

# REQUIRED: Add ECS cluster, task definition, and service resources as needed
# Terraform for Booking Service
# Define ECS/EC2, ALB/NLB, Cloud Map, IAM roles, ECR repo
# Fill in AWS resource definitions
