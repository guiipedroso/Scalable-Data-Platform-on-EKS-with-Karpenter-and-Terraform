resource "helm_release" "node_exporter" {
  name             = "prometheus-node-exporter"
  chart            = "https://github.com/prometheus-community/helm-charts/releases/download/prometheus-node-exporter-4.45.0/prometheus-node-exporter-4.45.0.tgz"
  namespace        = "monitoring"
  create_namespace = true

  values = [<<-EOT
    podAnnotations:
      prometheus.io/scrape: "true"
      prometheus.io/port: "9100"
      prometheus.io/path: "/metrics"
  EOT
  ]
}
