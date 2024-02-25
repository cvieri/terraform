data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v3.12.0"

  name = "${var.env}-vpc"

  cidr                             = var.vpc_cidr
  azs                              = data.aws_availability_zones.available.names
  private_subnets                  = var.vpc_private_subnets
  public_subnets                   = var.vpc_public_subnets
  enable_nat_gateway               = true
  single_nat_gateway               = false
  enable_dns_hostnames             = true
  enable_dns_support               = true
  private_subnet_tags              = {
    "kubernetes.io/cluster/${var.env}-eks" = "shared"
    "kubernetes.io/cluster/${var.env}-carparts-blue" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }
  public_subnet_tags     = {
    "kubernetes.io/cluster/${var.env}" = "shared"
    "kubernetes.io/cluster/${var.env}" = "shared"
    "kubernetes.io/role/elb"               = 1
  }

  tags = var.default_tags
}
