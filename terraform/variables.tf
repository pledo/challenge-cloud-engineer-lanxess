variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}


variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "pledo-test1-eks"
}

variable "postgres_password" {
  description = "RDS Postgresql password"
  type        = string
  default     = ""
}

variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}
variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "kube-version" {
  type    = string
  default = "36.2.0"
}