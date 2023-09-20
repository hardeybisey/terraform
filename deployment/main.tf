
provider "google" {
  project     = "electric-armor-395015"
  region      = "europe-west2"
  zone        = "europe-west2-c"
}

module "vpc-network" {
  source      = "/Users/hardey/Desktop/GITHUB/terraform/zero-to-hero/modules/vpc-network"
  vpc_network = "terraform-network"
}

module "firewall-rules" {
  source  = "/Users/hardey/Desktop/GITHUB/terraform/zero-to-hero/modules/firewall"
  firewall_name = "allow-ssh"
  vpc_network  = "terraform-network"
  target_tags = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]
  protocol = "tcp"
  ports    = [80,22]
  depends_on = [ module.vpc-network ]
}


resource "google_compute_instance" "default" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags = ["allow-ssh"]

  metadata = {
    ssh-keys = "hardey:${file("/Users/hardey/Desktop/GITHUB/terraform/deployment/key.pub")}"
  }

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = "terraform-network"
    access_config {
    }
  }
  connection {
    host        = self.network_interface[0].access_config[0].nat_ip
    type        = "ssh"
    user        = "ubuntu"
    timeout     = "50s"
    private_key = file("/Users/hardey/Desktop/GITHUB/terraform/deployment/key")
  }
  provisioner "file" {
    source      = "/Users/hardey/Desktop/GITHUB/terraform/deployment/app.py"
    destination = "/home/hardey/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from remote instance'",
      "sudo apt update -y",
      "sudo apt install -y python3-pip",
      "sudo pip3 install flask",
      "cd /home/hardey",
      "sudo python3 app.py",
    ]
  }
  depends_on = [ module.firewall-rules, module.vpc-network ]
}