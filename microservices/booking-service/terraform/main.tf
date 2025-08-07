terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Pins to AWS provider version 4.x
    }
  }
}

# AWS Provider Configuration
provider "aws" {
  region = "ap-south-1"  # Mumbai region
  
  # Optional: Uncomment if you need to specify a specific AWS profile
  # profile = "your-aws-profile-name"
  
  # Optional: Uncomment if you want to assume a specific role
  # assume_role {
  #   role_arn = "arn:aws:iam::ACCOUNT_ID:role/ROLE_NAME"
  # }
}
