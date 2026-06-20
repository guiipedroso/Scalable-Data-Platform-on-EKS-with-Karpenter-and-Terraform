data "aws_route53_zone" "grafana" {
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_acm_certificate" "grafana" {
  domain_name       = "grafana.${var.hosted_zone_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "grafana_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.grafana.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.grafana.zone_id
}

resource "aws_acm_certificate_validation" "grafana" {
  certificate_arn         = aws_acm_certificate.grafana.arn
  validation_record_fqdns = [for record in aws_route53_record.grafana_cert_validation : record.fqdn]
}

resource "helm_release" "grafana" {
  name             = "grafana"
  chart            = "https://github.com/grafana/helm-charts/releases/download/grafana-10.5.15/grafana-10.5.15.tgz"
  namespace        = "monitoring"
  create_namespace = true

  values = [templatefile("${path.module}/grafana/values.yml", {
    proxy_datasource_url = "http://localhost:8005/workspaces/${aws_prometheus_workspace.this.id}/"
    irsa_role_arn        = aws_iam_role.grafana_helm.arn
    certificate_arn      = aws_acm_certificate_validation.grafana.certificate_arn
    admin_password       = var.grafana_admin_password
    region               = var.region
    hostname             = "grafana.${var.hosted_zone_name}"
  })]

  depends_on = [aws_acm_certificate_validation.grafana]
}
