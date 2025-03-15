resource "helm_release" "prometheus" {
  name       = "prometheus"
  chart      = "https://github.com/prometheus-community/helm-charts/releases/download/prometheus-27.5.1/prometheus-27.5.1.tgz"
  namespace  = "monitoring"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "NodePort" # Or LoadBalancer in a cloud environment
  }

}


