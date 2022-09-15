// (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP

variable "name" {
  description = "The name of the ssh public key"
  type = string
}

variable "public_key" {
  description = "The content of the ssh public key"
  type = string
  nullable = false
  validation {
    condition = var.public_key != ""
    error_message = "ssh public key must be used"
  }
}