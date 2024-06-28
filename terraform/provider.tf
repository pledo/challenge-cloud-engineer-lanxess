terraform {
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "6.1.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.2"
    }

  }
}
# ------------------------- Providers

provider "aws" {
  profile = "lanxess"
  region  = var.region
  #shared_config_files = ""
  #shared_credentials_files = [""]
}



provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "argocd" {
  server_addr = "localhost:8081"
  insecure    = true
  username    = "admin"
  password    = ""

}

# Used to interact with the resources supported by Kubernetes.
# The provider needs to be configured with the proper credentials before it can be used.
provider "kubernetes" {
  config_path = "~/.kube/config"
}