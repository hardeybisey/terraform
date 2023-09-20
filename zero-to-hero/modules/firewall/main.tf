resource "google_compute_firewall" "allow_ssh" {
  name          = var.firewall_name
  network       = var.vpc_network
  target_tags   = var.target_tags
  source_ranges = var.source_ranges

  allow {
    protocol = var.protocol
    ports    = var.ports
  }
}