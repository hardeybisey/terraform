provider "google" {
  project     = "electric-armor-395015"
  region      = "europe-west2"
  zone        = "europe-west2-c"
  credentials = file("/Users/hardey/Desktop/GITHUB/terraform/key.json")
}

resource "google_storage_bucket" "terraform_state_bucket" {
  name          = "my_terraform_state_bucket"
  location      = "EU"
  force_destroy = true
  public_access_prevention = "enforced"
}

module "compute-instance" {
  source        = "./modules/compute-instance"
  instance_name = "terraform-instance"
  machine_type  = "f1-micro"
  boot_image    = "cos-cloud/cos-stable"
  vpc_network   = "terraform-network"
  depends_on    = [module.vpc-network]
}

module "vpc-network" {
  source      = "./modules/vpc-network"
  vpc_network = "terraform-network"
}