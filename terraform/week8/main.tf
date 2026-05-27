# terraform/week8/main.tf

# ─────────────────────────────────────────────────────────────────────────
# Deploys a Cloud Run service connected to your Week 7 VPC.
# Uses terraform_remote_state to read VPC outputs from Week 7 state.
# ─────────────────────────────────────────────────────────────────────────

terraform {

  required_version = ">= 1.6"

  backend "gcs" {
    bucket = "cis410-kaliabdulla-tfstate"
    prefix = "terraform/week8"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# ── Read VPC outputs from Week 7 state ───────────────────────────────────

data "terraform_remote_state" "week7" {

  backend = "gcs"

  config = {
    bucket = "cis410-kaliabdulla-tfstate"
    prefix = "terraform/week7"
  }
}

# ── Cloud Run service ────────────────────────────────────────────────────

resource "google_cloud_run_v2_service" "flask_app" {

  name     = "cis410-flask-app"
  location = var.region

  template {

    containers {

      image = var.container_image

      ports {
        container_port = 5000
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 3
    }

    # Connect Cloud Run to the VPC from Week 7

    vpc_access {

      network_interfaces {
        network    = data.terraform_remote_state.week7.outputs.vpc_name
        subnetwork = data.terraform_remote_state.week7.outputs.subnet_name
      }

      egress = "PRIVATE_RANGES_ONLY"
    }
  }
}

# ── Allow public internet access ─────────────────────────────────────────

resource "google_cloud_run_v2_service_iam_member" "public_access" {

  name     = google_cloud_run_v2_service.flask_app.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}