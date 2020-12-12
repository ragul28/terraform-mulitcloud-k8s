module "aws-vpc" {
  # Select subnet mode [public, private]
  source         = "./modules/vpc/private"
  project        = var.project
  vpc_cidr_block = var.vpc_cidr_block
}

module "aws-eks" {
  source  = "./modules/eks"
  project = var.project
  # Select subnet id based no mode [pub_subnet_ids, pvt_subnet_ids] 
  eks_subnet_ids = module.aws-vpc.pvt_subnet_ids
  eks_vpc_id     = module.aws-vpc.vpc_id
  instance_types = var.instance_types
  node_count     = var.node_count
  spot_instance_types = var.spot_instance_types
  spot_node_count     = var.spot_node_count
  # k8s_version    = var.k8s_version
}