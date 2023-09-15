output "external_ip-address" {
    description = "The public IP of the instance"
    value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}

output "internal_ip-address" {
    description = "The private IP of the instance"
    value = google_compute_instance.default.network_interface.0.network_ip
}

output "instance_name" {
    description = "The name of the instance"
    value = google_compute_instance.default.name
}

output "machine_type" {
    description = "The machine type of the instance"
    value = google_compute_instance.default.machine_type
}

output "boot_image" {
    description = "The boot image of the instance"
    value = google_compute_instance.default.boot_disk.0.initialize_params.0.image
}