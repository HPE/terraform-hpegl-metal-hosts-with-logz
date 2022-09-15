// (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP

variable "location" {
  description = "Textual representation of the resource location country:region:enter"
  type = string
}

variable "name" {
  description = "Name of the private network"
  type = string
}

variable "description" {
  description = "A description for the private network"
  type = string
}

variable "pool_name" {
  description = "Name of the private IP pool"
  type = string
}

variable "pool_description" {
  description = "A description for the network pool"
  type = string
}

variable "pool_ip_version" {
  description = "The IP version of the private network pool. One of IPv4 or IPv6"
  type = string
  validation {
    condition = var.pool_ip_version == "IPv4" || var.pool_ip_version == "IPv6"
    error_message = "Supported values are: IPv4 and IPv6"
  }
}

variable "pool_base_ip" {
  description = "The network part of the main IP pool of the private network. ex. 10.0.0.0"
  type = string
}

variable "pool_cidr" {
  description = "The netmask part of the main IP pool of the private network in CIDR notation. ex. /24"
  type = string
}

variable "pool_gateway" {
  description = "The gateway address of the main IP pool of the private network"
  type = string
}

variable "pool_dns" {
  description = "DNS server list for the main IP pool of the private network"
  type = list(string)
}

variable "pool_proxy" {
  description = "The proxy for the network pool. ex. http://10.0.0.60:8080"
  type = string
}

variable "pool_no_proxy" {
  description = "String list of excluded hosts from the proxy. ex. 10.0.0.5,www.hpe.com"
  type = string
}

variable "pool_ntp" {
  description = "NTP server list for the network pool"
  type = list(string)
}

variable "sources" {
  description = "IP ranges that are to be included in the pool within the base IP and netmask"
  type = list(object({base_ip = string, count = number}))
}
