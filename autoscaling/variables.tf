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

variable "karpenter" {
  type = object({
    controller_role_name   = string
    controller_policy_name = string
  })

  default = {
    controller_role_name   = "guiipedroso-dev-KarpenterControllerRole"
    controller_policy_name = "guiipedroso-dev-KarpenterControllerPolicy"
  }
}
