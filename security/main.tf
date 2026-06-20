terraform {
  required_version = ">= 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "guiipedroso-dev-terraform-state"
    key            = "security/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
  }
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
