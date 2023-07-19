variable "project" {
  type        = string
}

variable "region" {
  type        = string
}

variable "name_prefix" {
  type        = string
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
}

variable "cidr_subnetwork_width_delta" {
  type        = number
  default     = 4
}

variable "cidr_subnetwork_spacing" {
  type        = number
  default     = 0
}

variable "public_subnetwork_secondary_range_name" {
  type        = string
  default     = "public-cluster"
}

variable "public_services_secondary_range_name" {
  type        = string
  default     = "public-services"
}

variable "secondary_cidr_block" {
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_services_secondary_cidr_block" {
  type        = string
  default     = null
}

variable "private_services_secondary_cidr_block" {
  type        = string
  default     = null
}

variable "secondary_cidr_subnetwork_width_delta" {
  type        = number
  default     = 4
}

variable "secondary_cidr_subnetwork_spacing" {
  type        = number
  default     = 0
}

variable "log_config" {
  type = object({
    aggregation_interval = string
    flow_sampling        = number
    metadata             = string
  })

  default = {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

variable "allowed_public_restricted_subnetworks" {
  default     = []
  type        = list(string)
}