# main.tf - Minimal test configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Test resource - will only create a security group
resource "aws_security_group" "test_sg" {
  name        = "test-security-group"
  description = "Test if Terraform can create resources"
  vpc_id      = "vpc-0bc652bfc089f9e1a"  # Replace with your actual VPC ID

  tags = {
    Purpose = "Terraform connectivity test"
  }
}
