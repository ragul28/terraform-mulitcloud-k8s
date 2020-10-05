terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.41.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.gcp_region
}