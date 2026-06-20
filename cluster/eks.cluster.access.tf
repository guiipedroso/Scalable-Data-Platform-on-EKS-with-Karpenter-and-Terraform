resource "aws_eks_access_entry" "admin_user" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = local.admin_iam_user_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_user" {
  cluster_name  = aws_eks_cluster.this.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = local.admin_iam_user_arn

  access_scope {
    type = "cluster"
  }
}
