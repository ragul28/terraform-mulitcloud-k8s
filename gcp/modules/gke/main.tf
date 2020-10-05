# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project}-gke"
  location = var.gcp_region

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
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project
    }

    # preemptible  = true
    machine_type = var.instance_type
    tags         = ["gke-node", "${var.project}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

output "gke_cluster_name" {
  value       = google_container_cluster.primary.name
}