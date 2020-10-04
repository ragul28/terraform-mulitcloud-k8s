module "aws-vpc" {
  source         = "./modules/vpc"
  project        = var.project
  vpc_cidr_block = var.vpc_cidr_block
}

module "aws-eks" {
  source         = "./modules/eks"
  project        = var.project
  eks_subnet_ids = module.aws-vpc.subnet_ids
  eks_vpc_id     = module.aws-vpc.vpc_id
  instance_types = var.instance_types
  node_count     = var.node_count
  # k8s_version    = var.k8s_version
}