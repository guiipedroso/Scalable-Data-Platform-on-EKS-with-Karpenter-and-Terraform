variable "region" {
  description = "The region to deploy the application"
  type        = string
  default     = "us-east-1"
}

variable "assume_role" {
  type = object({
    role_arn    = string
    external_id = string
  })

  default = {
    role_arn    = "arn:aws:iam::YOUR_AWS_ACCOUNT_ID:role/terraform-develop-role"
    external_id = "YOUR_EXTERNAL_ID"
  }
}

variable "remote_backend" {
  description = "S3 bucket name for Terraform remote state"
  type = object({
    bucket = string
  })

  default = {
    bucket = "guiipedroso-dev-terraform-state"
  }
}
