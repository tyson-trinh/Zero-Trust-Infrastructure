resource "google_compute_address" "gitlab-server" {
  address_type = "EXTERNAL"
  name         = "gitlab-server"
  network_tier = "PREMIUM"
  project      = var.project
  region       = var.region
}