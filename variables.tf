variable "region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used as a prefix for resource naming"
  type        = string
  default     = "ml-platform"
}

variable "artifacts_bucket_name" {
  description = "Globally unique S3 bucket name for ML artifacts"
  type        = string
}

variable "notebook_instance_type" {
  description = "Instance type for the SageMaker notebook"
  type        = string
  default     = "ml.t3.medium"
}
