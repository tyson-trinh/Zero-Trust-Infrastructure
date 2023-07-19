output "name" {
  value = google_container_cluster.cluster.name
}

output "master_version" {
  value       = google_container_cluster.cluster.master_version
}

output "endpoint" {
  sensitive   = true
  value       = google_container_cluster.cluster.endpoint
}

output "client_certificate" {
  value       = base64decode(google_container_cluster.cluster.master_auth[0].client_certificate)
}

output "client_key" {
  value       = base64decode(google_container_cluster.cluster.master_auth[0].client_key)
}

output "cluster_ca_certificate" {
  value       = base64decode(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}