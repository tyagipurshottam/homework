resource "null_resource" "change_mode" {
  provisioner "local-exec" {
    command = "chmod 755 script.sh"
  }
}

resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "./script.sh"
  }
  depends_on = [null_resource.change_mode]
}

