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
  description = "Name tag of the VPC where the EKS cluster will be deployed"
  type        = string
  default     = "guiipedroso-dev-vpc"
}

variable "custom_domain" {
  description = "Full subdomain used for the EKS cluster ingress and ACM certificate"
  type        = string
  default     = "eks.devopsengineeracademy.com"
}

variable "hosted_zone_name" {
  description = "Root Route 53 hosted zone name (must already exist in the account)"
  type        = string
  default     = "devopsengineeracademy.com"
}

variable "admin_iam_user_name" {
  description = "IAM user name that will receive EKS cluster admin access"
  type        = string
  default     = "gui-workshop"
}

variable "eks_cluster" {
  type = object({
    name                      = string
    role_name                 = string
    version                   = string
    enabled_cluster_log_types = list(string)
    access_config = object({
      authentication_mode = string
    })
    node_group = object({
      name           = string
      role_name      = string
      instance_types = list(string)
      capacity_type  = string
      ami_type       = string
      scaling_config = object({
        desired_size = number
        max_size     = number
        min_size     = number
      })
    })
  })

  default = {
    name                      = "guiipedroso-dev-eks-cluster"
    role_name                 = "guiipedroso-dev-eks-cluster-role"
    version                   = "1.36"
    enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
    access_config = {
      authentication_mode = "API_AND_CONFIG_MAP"
    }
    node_group = {
      name           = "guiipedroso-dev-node-group"
      role_name      = "guiipedroso-dev-node-group-role"
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      ami_type       = "AL2023_x86_64_STANDARD"
      scaling_config = {
        desired_size = 3
        max_size     = 3
        min_size     = 3
      }
    }
  }
}
