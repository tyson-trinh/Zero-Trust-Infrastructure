variable "ssh_user" {}
variable "ssh_public_key" {}
variable "ssh_root_user" {}
variable "ssh_root_public_key" {}
variable "email" {}
variable "scope" {}
variable "project" {}
variable "region" {}

variable "location" {}

variable "cluster_name" {}

variable "cluster_service_account_name" {}

variable "cluster_service_account_description" {}

variable "kubectl_config_path" {}

variable "master_ipv4_cidr_block" {
  default     = "10.5.0.0/28"
}

variable "vpc_cidr_block" {
  default     = "10.3.0.0/16"
}

variable "public_subnetwork_secondary_range_name" {
  default     = "public-cluster"
}

variable "public_services_secondary_range_name" {
  default     = "public-services"
}

variable "public_services_secondary_cidr_block" {
  default     = null
}

variable "private_services_secondary_cidr_block" {
  default     = null
}

variable "secondary_cidr_subnetwork_width_delta" {
  default     = 4
}

variable "secondary_cidr_subnetwork_spacing" {
  default     = 0
}

variable "vpc_secondary_cidr_block" {
  default     = "10.4.0.0/16"
}