resource "aws_cloudwatch_log_group" "prometheus" {
  name = "/aws/prometheus/guiipedroso-dev"
}

resource "aws_prometheus_workspace" "this" {
  alias = "guiipedroso-dev-prometheus"

  logging_configuration {
    log_group_arn = "${aws_cloudwatch_log_group.prometheus.arn}:*"
  }
}
