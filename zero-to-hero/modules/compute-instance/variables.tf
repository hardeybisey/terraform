variable "instance_name" {
  description = "value of the instance name"
}
  
variable "machine_type" {
  description = "value of the machine type"
}

variable "boot_image" {
  description = "value of the image"
}

variable "vpc_network" {
  description = "value of the vpc network"
}

variable "tags" {
  description = "list of tags"
}

variable "ssh_keys" {
  description = "list of ssh keys"
}