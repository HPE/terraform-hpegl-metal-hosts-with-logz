// (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP
resource "hpegl_metal_network" "this" {
  name        = var.name
  description = var.description
  location    = var.location

  ip_pool {
    name          = var.pool_name
    description   = var.pool_description
    ip_ver        = var.pool_ip_version
    base_ip       = var.pool_base_ip
    netmask       = var.pool_cidr
    default_route = var.pool_gateway

    dns      = var.pool_dns
    proxy    = var.pool_proxy
    no_proxy = var.pool_no_proxy
    ntp      = var.pool_ntp

    dynamic "sources" {
      for_each = toset(var.sources)

      content {
        base_ip = sources.value.base_ip
        count = sources.value.count
      }
    }
  }
}
