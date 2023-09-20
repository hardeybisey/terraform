
provider "google" {
  project     = "electric-armor-395015"
  region      = "europe-west2"
  zone        = "europe-west2-c"
}

module "compute-instance" {
  source        = "/Users/hardey/Desktop/GITHUB/terraform/zero-to-hero/modules/compute-instance"
  instance_name = "terraform-instance"
  machine_type  = "f1-micro"
  boot_image    = "cos-cloud/cos-stable"
  vpc_network   = "terraform-network"
  depends_on    = [module.vpc-network]
}

module "vpc-network" {
  source      = "/Users/hardey/Desktop/GITHUB/terraform/zero-to-hero/modules/vpc-network"
  vpc_network = "terraform-network"
}