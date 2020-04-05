terraform {
  required_version = ">= 0.12.0"
  backend "gcs" {
    bucket = "aseem-cqrs-tf-state"
    prefix = "dev"
  }
}
provider "google" {
  version     = "~> 3.15"
  credentials = file("${var.gcp_credentials}")
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}
variable "gcp_credentials" {
  description = "Path to the GCP service account key"
}

variable "gcp_project" {
  description = "The GCP Project ID"
}

variable "gcp_region" {
  description = "The GCP Region"
}

variable "gcp_zone" {
  description = "The GCP Zone"
}
