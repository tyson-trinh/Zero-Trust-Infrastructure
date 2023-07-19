resource "google_compute_instance" "gitlab-server" {
  project = var.project
  name = "gitlab-server"
  machine_type = "e2-highcpu-8"
  zone = "asia-southeast1-a"
  can_ip_forward = true

  boot_disk {
    auto_delete = true
    device_name = "gitlab-server"
    initialize_params {
      image = "debian-cloud/debian-11-bullseye-v20220406"
      size  = 100
      type  = "pd-balanced"
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }

  network_interface {
    access_config {
      nat_ip       = google_compute_address.gitlab-server.address
      network_tier = "PREMIUM"
    }
  }

  service_account {
    email  = var.email
    scopes = var.scope
  }
}

output "gcp-gitlab-server-local-ip" {
  value = google_compute_instance.gitlab-server.network_interface[0].network_ip
}