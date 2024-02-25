data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_ami" "eks_default" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.eks_cluster_version}-v*"]
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.24.0"

  cluster_name    = "${var.env}"
  cluster_version = var.eks_cluster_version
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = false

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  tags                      = var.default_tags

  write_kubeconfig = false

  workers_group_defaults = {
    ami_id                                   = data.aws_ami.eks_default.image_id
    override_instance_types                  = ["c6a.large"]
    subnets                                  = module.vpc.private_subnets
    root_volume_type                         = "gp3"
    on_demand_percentage_above_base_capacity = 100
  }

  worker_groups_launch_template = [
    {
      name = "default"

      asg_desired_capacity = 1
      asg_min_size         = 1
      asg_max_size         = 3

      override_instance_types = ["c6a.xlarge"]

    }
  ]
}
