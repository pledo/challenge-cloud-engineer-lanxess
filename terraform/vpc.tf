module "vpc" {
  #source  = "terraform-aws-modules/vpc/aws"
  #version = "5.8.1"
  #Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=25322b6b6be69db6cca7f167d7b0e5327156a595"


  create_vpc = true
  name       = "test-vpc"

  cidr = "10.10.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  enable_dns_support     = true
  one_nat_gateway_per_az = false


  # Application subnets: 
  #         Private: 8k ip address. Reserve 6 spots, from 10.10.0.0 - 10.10.96.0
  #         Public:  1k ip address. Reserve 6 spots, from 10.10.96.0 - 10.0.120.0

  private_subnets       = ["10.10.0.0/20", "10.10.16.0/20", "10.10.32.0/20"] #
  private_subnet_suffix = "private-app"

  public_subnets       = ["10.10.96.0/22", "10.10.100.0/22", "10.10.104.0/22"]
  public_subnet_suffix = "public-app"

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }


  # Database subnets:
  # 1k ip address. Reserve 6 spots, from 10.10.108.0 - 10.10.116.0
  database_subnets = ["10.10.108.0/22", "10.10.112.0/22", "10.10.116.0/22"]

  # Intra subnets:
  # 1k ip address. Reserve 6 spots, from 10.10.116.0 - 10.10.124.0
  intra_subnets = ["10.10.120.0/22", "10.10.124.0/22", "10.10.128.0/22"]

}



