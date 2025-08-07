terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Terraform configuration for booking-service
provider "aws" {
  region = "ap-south-1"
}


