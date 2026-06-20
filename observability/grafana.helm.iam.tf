resource "aws_iam_role" "grafana_helm" {
  name = "guiipedroso-dev-GrafanaHelmRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRoleWithWebIdentity"
        Principal = {
          Federated = local.eks_oidc_provider_arn
        }
        Condition = {
          StringEquals = {
            "${local.eks_oidc_url}:sub" = "system:serviceaccount:monitoring:grafana"
            "${local.eks_oidc_url}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "grafana_helm_amp_query" {
  role       = aws_iam_role.grafana_helm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusQueryAccess"
}
