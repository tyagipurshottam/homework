resource "helm_release" "mysql" {
    name = "mysql"
    chart = "https://charts.bitnami.com/bitnami/mysql-9.3.4.tgz"
    namespace = "foo"
    create_namespace = true
    version = "9.3.4"
    values = [file("values/mysql.yaml")]
}
