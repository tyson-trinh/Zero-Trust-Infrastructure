terraform {
  required_version = ">= 1.3.5"
}

resource "google_compute_network" "vpc" {
  name    = "${var.name_prefix}-network"
  project = var.project

  auto_create_subnetworks = "false"

  routing_mode = "REGIONAL"
}

resource "google_compute_router" "vpc_router" {
  name = "${var.name_prefix}-router"

  project = var.project
  region  = var.region
  network = google_compute_network.vpc.self_link
}

resource "google_compute_subnetwork" "vpc_subnetwork_public" {
  name = "${var.name_prefix}-subnetwork-public"

  project = var.project
  region  = var.region
  network = google_compute_network.vpc.self_link

  private_ip_google_access = true
  ip_cidr_range            = cidrsubnet(var.cidr_block, var.cidr_subnetwork_width_delta, 0)

  secondary_ip_range {
    range_name = var.public_subnetwork_secondary_range_name
    ip_cidr_range = cidrsubnet(
      var.secondary_cidr_block,
      var.secondary_cidr_subnetwork_width_delta,
      0
    )
  }

  secondary_ip_range {
    range_name = var.public_services_secondary_range_name
    ip_cidr_range = var.public_services_secondary_cidr_block != null ? var.public_services_secondary_cidr_block : cidrsubnet(
      var.secondary_cidr_block,
      var.secondary_cidr_subnetwork_width_delta,
      1 * (2 + var.secondary_cidr_subnetwork_spacing)
    )
  }

  dynamic "log_config" {
    for_each = var.log_config == null ? [] : tolist([var.log_config])

    content {
      aggregation_interval = var.log_config.aggregation_interval
      flow_sampling        = var.log_config.flow_sampling
      metadata             = var.log_config.metadata
    }
  }
}

resource "google_compute_router_nat" "vpc_nat" {
  name = "${var.name_prefix}-nat"

  project = var.project
  region  = var.region
  router  = google_compute_router.vpc_router.name

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.vpc_subnetwork_public.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_subnetwork" "vpc_subnetwork_private" {
  name = "${var.name_prefix}-subnetwork-private"

  project = var.project
  region  = var.region
  network = google_compute_network.vpc.self_link

  private_ip_google_access = true
  ip_cidr_range = cidrsubnet(
    var.cidr_block,
    var.cidr_subnetwork_width_delta,
    1 * (1 + var.cidr_subnetwork_spacing)
  )

  secondary_ip_range {
    range_name = "private-services"
    ip_cidr_range = var.private_services_secondary_cidr_block != null ? var.private_services_secondary_cidr_block : cidrsubnet(
      var.secondary_cidr_block,
      var.secondary_cidr_subnetwork_width_delta,
      1 * (1 + var.secondary_cidr_subnetwork_spacing)
    )
  }

  dynamic "log_config" {
    for_each = var.log_config == null ? [] : tolist([var.log_config])

    content {
      aggregation_interval = var.log_config.aggregation_interval
      flow_sampling        = var.log_config.flow_sampling
      metadata             = var.log_config.metadata
    }
  }
}


module "network_firewall" {
  source = "../network-firewall"

  name_prefix = var.name_prefix

  project                               = var.project
  network                               = google_compute_network.vpc.self_link
  allowed_public_restricted_subnetworks = var.allowed_public_restricted_subnetworks

  public_subnetwork  = google_compute_subnetwork.vpc_subnetwork_public.self_link
  private_subnetwork = google_compute_subnetwork.vpc_subnetwork_private.self_link
}