locals {
  eks_cluster_arn            = data.terraform_remote_state.eks_cluster.outputs.eks_cluster_arn
  eks_cluster_name           = data.terraform_remote_state.eks_cluster.outputs.eks_cluster_name
  eks_cluster_security_group = data.terraform_remote_state.eks_cluster.outputs.eks_cluster_security_group
  eks_oidc_provider_arn      = data.terraform_remote_state.eks_cluster.outputs.kubernetes_oidc_provider_arn
  eks_oidc_url               = replace(data.terraform_remote_state.eks_cluster.outputs.kubernetes_oidc_provider_url, "https://", "")
}
