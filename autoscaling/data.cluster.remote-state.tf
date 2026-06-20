data "terraform_remote_state" "eks_cluster" {
  backend = "s3"

  config = {
    bucket = "guiipedroso-dev-terraform-state"
    key    = "eks-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}
