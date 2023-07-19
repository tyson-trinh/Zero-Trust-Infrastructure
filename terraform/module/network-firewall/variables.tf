variable "network" {
  type        = string
}

variable "public_subnetwork" {
  type        = string
}

variable "allowed_public_restricted_subnetworks" {
  default     = []
  type        = list(string)
}

variable "private_subnetwork" {
  type        = string
}

variable "project" {
  type        = string
}

variable "name_prefix" {
  type        = string
}