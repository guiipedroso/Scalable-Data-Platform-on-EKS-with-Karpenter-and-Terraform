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

variable "vpc_name" {
  description = "Name tag of the VPC used to look up private subnets for Grafana"
  type        = string
  default     = "guiipedroso-dev-vpc"
}

variable "hosted_zone_name" {
  description = "Root Route 53 hosted zone name"
  type        = string
  default     = "devopsengineeracademy.com"
}

variable "grafana_admin_password" {
  description = "Admin password for the Grafana open source deployment (change before production use)"
  type        = string
  sensitive   = true
}
