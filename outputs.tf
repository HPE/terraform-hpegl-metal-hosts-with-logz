output "logz_host_ips" {
  value = {
    logging-proxy = var.enable_logging ? hpegl_metal_host.logz_bridge.0.name : "logging not enabled"
    logging-proxy-ips = var.enable_logging ? hpegl_metal_host.logz_bridge.0.connections : null
  }
}

output "hosts_ips" {
  value = zipmap(hpegl_metal_host.hosts.*.name,  hpegl_metal_host.hosts.*.connections)
}
