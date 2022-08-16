variable "location" {
  description = "GreenLake metal service location"
  type = string
}

variable "project_id" {
  description = "GreenLake metal project id"
  type = string
}

variable "rest_url" {
  description = "GreenLake metal service url"
  # this should change to point to production instance
  default = "https://quake.intg.hpedevops.net:443"
}

variable "prefix" {
  description = "A prefix to be added to created resources"
  type = string
}

variable "host_count" {
  description = "Number of hosts to create. Not including logging proxy if logging is enabled"
  type = number
}

variable "machine_size" {
  description = "The machine size for the hosts"
  type = string
}

variable "linux_image_flavor" {
  description = "The linux image flavor for the hosts"
  type = string
  # only ubuntu is supported for hosts at the moment
  default = "ubuntu"
}

variable "linux_image_version" {
  description = "The linux image version for the hosts"
  type = string
  # only ubuntu is supported for hosts at the moment
  default = "18.04"
}

variable "public_key_name" {
  description = "The name of the ssh public key"
  type = string
}

variable "public_key" {
  description = "The content of the ssh public key"
  type = string
  nullable = false
}

variable "enable_logging" {
  description = "Deploy and configure logging infrastructure for Logzio"
  # This will deploy a logging proxy with logstash and install and configure
  # filebeat to other hosts.
  type = bool
  default = true
}

variable "logging_proxy_public_key_name" {
  description = "The name of the ssh public key for the logging proxy"
  type = string
  default = null
}

variable "logging_proxy_public_key" {
  description = "The content of the ssh public key for the logging proxy"
  type = string
  default = null
}

variable "logging_proxy_machine_size" {
  description = "The machine size for the hosts"
  type = string
  default = null
}

variable "logzio_ship_token" {
  description = "Logzio shipping token"
  type = string
  sensitive = true
  default = null
}

variable "logzio_service_url" {
  description = "logzio service sub-account url"
  type = string
  default = null
}

variable "logzio_service_port" {
  description = "logzio service port"
  type = number
  default = null
}

variable "logging_network_pool_ip_version" {
  description = "The IP version of the logging network pool. One of IPv4 or IPv6"
  type = string
  default = null
}

variable "logging_network_pool_base_ip" {
  description = "The network part of the main IP pool of the logging network. ex. 10.0.0.0"
  type = string
  default = null
}

variable "logging_network_pool_cidr" {
  description = "The netmask part of the main IP pool of the logging network in CIDR notation. ex. /24"
  type = string
  default = null
}
