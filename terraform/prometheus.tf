resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stackr"
  namespace  = var.namespace
  version    = var.kube-version
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
}

module "kube" {
  #source  = "git::https://github.com/terraform-aws-modules/terraform-aws-rds.git?ref=2648d6fc4e5fb1f98c2914aa2be902476e68cc7a"
  source = "git::https://github.com/prometheus-operator/kube-prometheus.git?ref=2648d6fc4e5fb1f98c2914aa2be902476e68cc7a"
  #kube-version = "36.2.0"
}