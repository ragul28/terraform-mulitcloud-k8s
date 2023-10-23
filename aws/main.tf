module "aws-vpc" {
  source = "./modules/vpc"

  project                   = var.project
  main_vpc_cidr_block       = var.main_vpc_cidr_block
  secondary_vpc_cidr_blocks = var.secondary_vpc_cidr_blocks

  az_set          = var.az_set
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  enable_natgw    = var.enable_natgw
}

module "aws-eks" {
  source              = "./modules/eks"
  project             = var.project
  eks_subnet_ids      = module.aws-vpc.pvt_subnet_ids
  eks_vpc_id          = module.aws-vpc.vpc_id
  instance_types      = var.instance_types
  node_count          = var.node_count
  spot_instance_types = var.spot_instance_types
  spot_node_count     = var.spot_node_count
  eks_version         = var.eks_version
}
