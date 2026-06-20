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

variable "waf" {
  type = object({
    name  = string
    scope = string
    custom_response_body = object({
      key          = string
      content      = string
      content_type = string
    })
    visibility_config = object({
      cloudwatch_metrics_enabled = bool
      metric_name                = string
      sampled_requests_enabled   = bool
    })
  })

  default = {
    name  = "guiipedroso-dev-waf-webacl"
    scope = "REGIONAL"
    custom_response_body = {
      key          = "403-ForbiddenResponse"
      content      = "You are not allowed to perform the requested action."
      content_type = "APPLICATION_JSON"
    }
    visibility_config = {
      cloudwatch_metrics_enabled = true
      metric_name                = "guiipedroso-dev-waf-metrics"
      sampled_requests_enabled   = true
    }
  }
}
