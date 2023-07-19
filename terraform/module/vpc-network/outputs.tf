output "network" {
  value       = google_compute_network.vpc.self_link
}

output "public_subnetwork" {
  value       = google_compute_subnetwork.vpc_subnetwork_public.self_link
}

output "public_subnetwork_name" {
  value       = google_compute_subnetwork.vpc_subnetwork_public.name
}

output "public_subnetwork_cidr_block" {
  value = google_compute_subnetwork.vpc_subnetwork_public.ip_cidr_range
}

output "public_subnetwork_gateway" {
  value = google_compute_subnetwork.vpc_subnetwork_public.gateway_address
}

output "public_subnetwork_secondary_cidr_block" {
  value = google_compute_subnetwork.vpc_subnetwork_public.secondary_ip_range[0].ip_cidr_range
}

output "public_subnetwork_secondary_range_name" {
  value = google_compute_subnetwork.vpc_subnetwork_public.secondary_ip_range[0].range_name
}

output "public_services_secondary_cidr_block" {
  value = google_compute_subnetwork.vpc_subnetwork_public.secondary_ip_range[1].ip_cidr_range
}

output "public_services_secondary_range_name" {
  value = google_compute_subnetwork.vpc_subnetwork_public.secondary_ip_range[1].range_name
}

output "private_subnetwork" {
  value       = google_compute_subnetwork.vpc_subnetwork_private.self_link
}

output "private_subnetwork_name" {
  value       = google_compute_subnetwork.vpc_subnetwork_private.name
}

output "private_subnetwork_cidr_block" {
  value = google_compute_subnetwork.vpc_subnetwork_private.ip_cidr_range
}

output "private_subnetwork_gateway" {
  value = google_compute_subnetwork.vpc_subnetwork_private.gateway_address
}

output "private_subnetwork_secondary_cidr_block" {
  value = google_compute_subnetwork.vpc_subnetwork_private.secondary_ip_range[0].ip_cidr_range
}

output "private_subnetwork_secondary_range_name" {
  value = google_compute_subnetwork.vpc_subnetwork_private.secondary_ip_range[0].range_name
}

output "public" {
  value       = module.network_firewall.public
}

output "public_restricted" {
  value       = module.network_firewall.public_restricted
}

output "private" {
  value       = module.network_firewall.private
}

output "private_persistence" {
  value       = module.network_firewall.private_persistence
}