resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "3.35.4"
  values           = [file("values/argocd.yaml")]
  #depends_on       = [module.eks]

}

#resource "argocd_application" "springboot-sample" {
#  metadata {
#    name      = "springboot-sample"
#    namespace = "argocd"
#  }
#
#  spec {
#  #  project = "default"
#    destination {
#      server    = "https://kubernetes.default.svc"
#      namespace = "test-apps"
#    }
#    source {
#      repo_url = "https://github.com/pledo/challenge-cloud-engineer-lanxess.git"
#      target_revision = "feat/argocd-giops"
#      path = "cicd/argocd/overlays/test"
#    }
#  }
#}
