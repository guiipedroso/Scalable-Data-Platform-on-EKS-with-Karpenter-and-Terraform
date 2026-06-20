terraform {
  required_version = ">= 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # This stack intentionally uses local state.
  # It creates the S3 bucket and DynamoDB table used by all other stacks.
  # Committing terraform.tfstate for this stack to version control is acceptable
  # since it only manages 2 non-sensitive resources.
  backend "local" {}
}

provider "aws" {
  region = var.region

  assume_role {
    role_arn    = var.assume_role.role_arn
    external_id = var.assume_role.external_id
  }

  default_tags {
    tags = {
      Environment = "dev"
      Project     = "eks-data-platform"
      Owner       = "guiipedroso"
      ManagedBy   = "Terraform"
    }
  }
}
