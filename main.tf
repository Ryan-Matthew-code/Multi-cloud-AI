# GCP module: provisions a GCS bucket for ML artifacts and a Vertex AI
# Workbench instance for model development.

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "ml_artifacts" {
  name                        = var.artifacts_bucket_name
  location                    = var.region
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

resource "google_service_account" "vertex_sa" {
  account_id   = "${var.project_name}-vertex-sa"
  display_name = "Vertex AI service account for ${var.project_name}"
}

resource "google_project_iam_member" "vertex_ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.vertex_sa.email}"
}

resource "google_project_iam_member" "storage_object_admin" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.vertex_sa.email}"
}

resource "google_notebooks_instance" "ml_workbench" {
  name         = "${var.project_name}-workbench"
  location     = var.zone
  machine_type = var.machine_type

  vm_image {
    project      = "deeplearning-platform-release"
    image_family = "common-cpu-notebooks"
  }

  service_account = google_service_account.vertex_sa.email
}
