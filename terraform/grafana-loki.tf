#resource "helm_release" "loki" {
#  name       = "loki"
#  repository = "https://grafana.github.io/helm-charts"
#  chart      = "loki"
#  #version    = "2.9.3"
#  namespace  = "monitoring"
#
#  #values = [
#  #  file("values/grafana-loki.yaml")
#  #]
#}