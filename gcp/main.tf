module "gcp-vpc" {
  source         = "./modules/vpc"
  gcp_project_id = var.gcp_project_id
  project_name   = var.project_name
  gcp_region     = var.gcp_region
  vpc_cidr_block = var.vpc_cidr_block
}

module "gcp-gke" {
  source                        = "./modules/gke"
  gcp_project_id                = var.gcp_project_id
  project_name                  = var.project_name
  gcp_region                    = var.gcp_region
  gcp_zone                      = var.gcp_zone
  gke_vpc                       = module.gcp-vpc.gke_vpc
  gke_subnet                    = module.gcp-vpc.gke_subnet
  gke_subnet_secondary_ip_range = module.gcp-vpc.gke_subnet_secondary_ip_range
  instance_type                 = var.instance_type
  node_count                    = var.node_count
  gke_username                  = var.gke_username
  gke_password                  = var.gke_password
  gke_env_mode                  = var.gke_env_mode
}