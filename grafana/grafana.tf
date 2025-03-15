resource "helm_release" "grafana" {
  name       = "grafana"
  chart      = "https://github.com/grafana/helm-charts/releases/download/grafana-8.10.3/grafana-8.10.3.tgz"
  namespace  = "monitoring"
  create_namespace = true
  values = [file("values/grafana-values.yaml")]

  provisioner "local-exec" {
    command = <<EOT
      kubectl apply -f kube-bench.yaml;
    EOT
  
  }

}







