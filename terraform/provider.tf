terraform {
  backend "http" {
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.7.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.43.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.7.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 1.1.1"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region

  scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

provider "google-beta" {
  project = var.project
  region  = var.region

  scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_client_config" "client" {}

data "google_client_openid_userinfo" "terraform_user" {}

provider "kubernetes" {

  load_config_file       = false
  host                   = data.template_file.gke_host_endpoint.rendered
  token                  = data.template_file.access_token.rendered
  cluster_ca_certificate = data.template_file.cluster_ca_certificate.rendered
}

provider "helm" {

  kubernetes {
    host                   = data.template_file.gke_host_endpoint.rendered
    token                  = data.template_file.access_token.rendered
    cluster_ca_certificate = data.template_file.cluster_ca_certificate.rendered
    load_config_file       = false
  }
}

