terraform {
  required_version = ">= 1.3.5"
}

data "google_compute_subnetwork" "public_subnetwork" {
  self_link = var.public_subnetwork
}

data "google_compute_subnetwork" "private_subnetwork" {
  self_link = var.private_subnetwork
}

locals {
  public              = "public"
  public_restricted   = "public-restricted"
  private             = "private"
  private_persistence = "private-persistence"
}

resource "google_compute_firewall" "public_allow_all_inbound" {
  name = "${var.name_prefix}-public-allow-ingress"

  project = var.project
  network = var.network

  target_tags   = [local.public]
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "public_restricted_allow_inbound" {

  count = length(var.allowed_public_restricted_subnetworks) > 0 ? 1 : 0

  name = "${var.name_prefix}-public-restricted-allow-ingress"

  project = var.project
  network = var.network

  target_tags   = [local.public_restricted]
  direction     = "INGRESS"
  source_ranges = var.allowed_public_restricted_subnetworks

  priority = "1000"

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "private_allow_all_network_inbound" {
  name = "${var.name_prefix}-private-allow-ingress"

  project = var.project
  network = var.network

  target_tags = [local.private]
  direction   = "INGRESS"

  source_ranges = [
    data.google_compute_subnetwork.public_subnetwork.ip_cidr_range,
    data.google_compute_subnetwork.public_subnetwork.secondary_ip_range[0].ip_cidr_range,
    data.google_compute_subnetwork.public_subnetwork.secondary_ip_range[1].ip_cidr_range,
    data.google_compute_subnetwork.private_subnetwork.ip_cidr_range,
    data.google_compute_subnetwork.private_subnetwork.secondary_ip_range[0].ip_cidr_range,
  ]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "private_allow_restricted_network_inbound" {
  name = "${var.name_prefix}-allow-restricted-inbound"

  project = var.project
  network = var.network

  target_tags = [local.private_persistence]
  direction   = "INGRESS"

  source_tags = [local.private, local.private_persistence]

  priority = "1000"

  allow {
    protocol = "all"
  }
}