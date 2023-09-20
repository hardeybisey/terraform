resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  tags = var.tags

  metadata = {
    ssh-keys = var.ssh_keys
  }

  boot_disk {
    initialize_params {
      image = var.boot_image
    }
  }

  network_interface {
    network = var.vpc_network
    access_config {
    }
  }
}