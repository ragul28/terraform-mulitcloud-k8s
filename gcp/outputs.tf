output "vpc" {
  value = module.gcp-vpc.gke_vpc
}

output "subnet" {
  value = module.gcp-vpc.gke_subnet
}

output "gke_cluster_name" {
  value = module.gcp-gke.gke_cluster_name
}