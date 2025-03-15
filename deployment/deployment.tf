resource "null_resource" "run_kubectl" {
  provisioner "local-exec" {
    command = "kubectl apply -f application.yaml"
  }
}