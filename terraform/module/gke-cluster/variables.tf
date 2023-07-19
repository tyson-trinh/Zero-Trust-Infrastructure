variable "project" {
  type        = string
}

variable "location" {
  type        = string
}

variable "name" {
  type        = string
}

variable "network" {
  type        = string
}

variable "subnetwork" {
  type        = string
}

variable "cluster_secondary_range_name" {
  type        = string
}

variable "description" {
  type        = string
  default     = ""
}

variable "kubernetes_version" {
  type        = string
  default     = "latest"
}

variable "logging_service" {
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "horizontal_pod_autoscaling" {
  type        = bool
  default     = true
}

variable "http_load_balancing" {
  type        = bool
  default     = true
}

variable "enable_private_nodes" {
  type        = bool
  default     = false
}

variable "disable_public_endpoint" {
  type        = bool
  default     = false
}

variable "master_ipv4_cidr_block" {
  type        = string
  default     = ""
}

variable "network_project" {
  type        = string
  default     = ""
}

variable "master_authorized_networks_config" {
  type        = list(any)
  default     = []
}

variable "maintenance_start_time" {
  type        = string
  default     = "05:00"
}

variable "stub_domains" {
  type        = map(string)
  default     = {}
}

variable "non_masquerade_cidrs" {
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

variable "ip_masq_resync_interval" {
  type        = string
  default     = "60s"
}

variable "ip_masq_link_local" {
  type        = bool
  default     = false
}

variable "alternative_default_service_account" {
  type        = string
  default     = null
}

variable "resource_labels" {
  type        = map(any)
  default     = {}
}

variable "enable_legacy_abac" {
  type        = bool
  default     = false
}

variable "enable_network_policy" {
  type        = bool
  default     = true
}

variable "basic_auth_username" {
  type        = string
  default     = ""
}

variable "basic_auth_password" {
  type        = string
  default     = ""
}

variable "enable_client_certificate_authentication" {
  type        = bool
  default     = false
}

variable "gsuite_domain_name" {
  type        = string
  default     = null
}

variable "secrets_encryption_kms_key" {
  type        = string
  default     = null
}

variable "enable_vertical_pod_autoscaling" {
  type        = string
  default     = false
}

variable "services_secondary_range_name" {
  type        = string
  default     = null
}

variable "enable_workload_identity" {
  default     = false
  type        = bool
}

variable "identity_namespace" {
  default     = null
  type        = string
}