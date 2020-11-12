# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_name}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_name}-subnet"
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
  # ip_cidr_range = var.vpc_cidr_block
  ip_cidr_range = cidrsubnet(var.vpc_cidr_block, 4, 0)

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.project_name}-pod-range"
    ip_cidr_range = cidrsubnet(var.vpc_cidr_block, 4, 1)
  }

  secondary_ip_range {
    range_name    = "${var.project_name}-svc-range"
    ip_cidr_range = cidrsubnet(var.vpc_cidr_block, 4, 2)
  }
}

# external ip for NAT gateway 
resource "google_compute_address" "nat" {
  name    = "${var.project_name}-natip"
  project = var.gcp_project_id
  region  = var.gcp_region
}

# cloud router - cloud NAT
resource "google_compute_router" "router" {
  name    = "${var.project_name}-router"
  project = var.gcp_project_id
  region  = var.gcp_region
  network = google_compute_network.vpc.self_link

  bgp {
    asn = 64514
  }
}

# cloud NAT
resource "google_compute_router_nat" "nat" {
  name    = "${var.project_name}-nat"
  project = var.gcp_project_id
  router  = google_compute_router.router.name
  region  = var.gcp_region

  nat_ip_allocate_option = "MANUAL_ONLY"

  nat_ips = [google_compute_address.nat.self_link]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnet.self_link
    source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE", "LIST_OF_SECONDARY_IP_RANGES"]

    secondary_ip_range_names = [
      google_compute_subnetwork.subnet.secondary_ip_range.0.range_name,
      google_compute_subnetwork.subnet.secondary_ip_range.1.range_name,
    ]
  }
}

output "gke_vpc" {
  value       = google_compute_network.vpc.name
}

output "gke_subnet" {
  value       = google_compute_subnetwork.subnet.name
}

output "gke_subnet_secondary_ip_range" {
  value       = google_compute_subnetwork.subnet.secondary_ip_range
}