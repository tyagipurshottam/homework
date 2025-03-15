module "minikube" {
  source = "./minikube"
}

module "argocd" {
  source = "./argocd"
  depends_on = [module.minikube]
}

module "mysql" {
  source = "./mysql"
  depends_on = [module.argocd]
}


module "deployment" {
  source = "./deployment"
  depends_on = [module.mysql]
}

module "prometheus" {
  source = "./prometheus"
  depends_on = [module.deployment]
}
module "grafana" {
  source = "./grafana"
  depends_on = [module.prometheus]
}



output "argocd_url" {
  value = [
      "kubectl port-forward svc/argocd-server -n argocd  --address 0.0.0.0 8080:443 &",
      "https://<aws_host_ip>:8080",
      "user=admin",
      "passwword=kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
    ]
}

output "prometheus_url" {
  value = [
      "kubectl port-forward svc/prometheus-server -n monitoring  --address 0.0.0.0 7070:80 &",
      "https://<aws_host_ip>:7070",
      "user=admin",
      "passwword=kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
    ]
}

output "grafana_url" {
  value = [
      "kubectl port-forward svc/grafana -n monitoring  --address 0.0.0.0 9090:80 &",
      "https://<aws_host_ip>:9090",
      "user=admin",
      "passwword=admin"
    ]
}


output "kube-bench" {
  value = [
      "Kube-bench is a tool that checks if a Kubernetes deployment follows security best practices as defined by the CIS Kubernetes Benchmark. It automates security audits, providing reports on compliance and remediation guidance",
       "kubectl logs `kubectl get po  | awk '{print $1}' | tail -n 1` > kube-bench.txt",
      "cat kube-bench.txt"
    ]
}
