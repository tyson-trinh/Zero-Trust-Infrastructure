variable "project" {
  type        = string
}

variable "name" {
  type        = string
}

variable "description" {
  type        = string
  default     = ""
}

variable "service_account_roles" {
  type        = list(string)
  default     = []
}