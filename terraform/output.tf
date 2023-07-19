output "cluster_endpoint" {
  sensitive   = true
  value       = module.gke_cluster.endpoint
}

output "client_certificate" {
  value       = module.gke_cluster.client_certificate
}

output "client_key" {
  sensitive   = true
  value       = module.gke_cluster.client_key
}

output "cluster_ca_certificate" {
  sensitive   = true
  value       = module.gke_cluster.cluster_ca_certificate
}