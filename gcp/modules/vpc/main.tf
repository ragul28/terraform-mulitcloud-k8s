# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project}-subnet"
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.vpc_cidr_block
}

output "gke_vpc" {
  value       = google_compute_network.vpc.name
}

output "gke_subnet" {
  value       = google_compute_subnetwork.subnet.name
}