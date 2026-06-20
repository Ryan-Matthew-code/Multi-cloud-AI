variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
  default     = "ml-platform"
}

variable "region" {
  description = "GCP region for regional resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone for zonal resources (e.g., notebook instance)"
  type        = string
  default     = "us-central1-a"
}

variable "artifacts_bucket_name" {
  description = "Globally unique GCS bucket name for ML artifacts"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the Vertex AI Workbench instance"
  type        = string
  default     = "n1-standard-4"
}
