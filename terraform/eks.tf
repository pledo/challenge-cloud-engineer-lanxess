locals {
  cluster_name                      = "${var.cluster_name}-${random_string.suffix.result}"
  ebs_csi_service_account_namespace = "kube-system"
  ebs_csi_service_account_name      = "ebs-csi-controller-sa"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}
# ------------------------------ EKS 

data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.39.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
  #depends_on                    = [module.eks]
}

module "eks" {
  source                                   = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=73b752a1e365808a7214f064845e958e65c548bd"
  cluster_name                             = local.cluster_name
  cluster_version                          = "1.30"
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    aws-ebs-csi-driver = {
      service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
    }
  }

  eks_managed_node_groups = {
    app = {
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.small"]

      min_size = 3
      max_size = 3
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 3
    }
  }

  #depends_on = [module.vpc]
}
