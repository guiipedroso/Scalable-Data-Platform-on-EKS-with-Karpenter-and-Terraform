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

variable "vpc" {
  type = object({
    cidr_block               = string
    name                     = string
    eks_cluster_name         = string
    internet_gateway_name    = string
    nat_gateway_name         = string
    eip_name                 = string
    public_route_table_name  = string
    private_route_table_name = string
    public_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
    private_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
    observability_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
  })

  default = {
    name                     = "guiipedroso-dev-vpc"
    cidr_block               = "10.0.0.0/16"
    eks_cluster_name         = "guiipedroso-dev-eks-cluster"
    internet_gateway_name    = "internet-gateway"
    public_route_table_name  = "public-route-table"
    private_route_table_name = "private-route-table"
    nat_gateway_name         = "nat-gateway"
    eip_name                 = "nat-gateway-eip"
    public_subnets = [
      {
        name                    = "public-subnet-us-east-1a"
        cidr_block              = "10.0.0.0/20"
        availability_zone       = "us-east-1a"
        map_public_ip_on_launch = true
      },
      {
        name                    = "public-subnet-us-east-1b"
        cidr_block              = "10.0.16.0/20"
        availability_zone       = "us-east-1b"
        map_public_ip_on_launch = true
      }
    ]
    private_subnets = [
      {
        name                    = "private-subnet-us-east-1a"
        cidr_block              = "10.0.32.0/20"
        availability_zone       = "us-east-1a"
        map_public_ip_on_launch = false
      },
      {
        name                    = "private-subnet-us-east-1b"
        cidr_block              = "10.0.48.0/20"
        availability_zone       = "us-east-1b"
        map_public_ip_on_launch = false
      }
    ]
    observability_subnets = [
      {
        name                    = "private-observability-subnet-us-east-1a"
        cidr_block              = "10.0.64.0/20"
        availability_zone       = "us-east-1a"
        map_public_ip_on_launch = false
      },
      {
        name                    = "private-observability-subnet-us-east-1b"
        cidr_block              = "10.0.80.0/20"
        availability_zone       = "us-east-1b"
        map_public_ip_on_launch = false
      }
    ]
  }
}
