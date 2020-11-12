# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_name}-gke"
  location = var.gcp_zone != "" ? var.gcp_zone : var.gcp_region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.gke_vpc
  subnetwork = var.gke_subnet

  master_auth {
    username = var.gke_username
    password = var.gke_password

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  network_policy {
    enabled = "true"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.gke_subnet_secondary_ip_range.0.range_name
    services_secondary_range_name = var.gke_subnet_secondary_ip_range.1.range_name
  }

  private_cluster_config {
    enable_private_nodes    = "true"
    enable_private_endpoint = "false"
    master_ipv4_cidr_block  = "172.16.0.16/28"
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  cluster    = google_container_cluster.primary.name
  
  # if zone defined create zonal else regional cluster. 
  location   = var.gcp_zone != "" ? var.gcp_zone : var.gcp_region
  node_count = var.node_count
  # node_locations = [""]

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_name
    }

    preemptible  = var.enable_preemptible

    machine_type = var.instance_type
    tags         = ["gke-node", "${var.project_name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

output "gke_cluster_name" {
  value       = google_container_cluster.primary.name
}