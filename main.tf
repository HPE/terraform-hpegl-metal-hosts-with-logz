module "linux" {
  source = "./modules/d/linux_image"
  image_flavor = var.linux_image_flavor
  image_version = var.linux_image_version
}

module "ssh_key" {
  source = "./modules/r/ssh_key"
  name = var.public_key_name
  public_key = var.public_key
}

resource "hpegl_metal_host" "hosts" {
  count         = var.host_count
  name          = "${var.prefix}-host-${count.index}"
  image         = module.linux.first_image
  machine_size  = var.machine_size
  ssh           = [module.ssh_key.id]
  networks      = flatten(["Public", "Storage-Client", var.enable_logging ? [module.logging_network.0.name] : []])
  network_route = "Public"
  location      = var.location
  description   = "Hello from Terraform"
  user_data = var.enable_logging ? templatefile("${path.module}/cloud-init/config.yaml.tpl", {
    TF_LOG_COMPONENT = "filebeat",
    TF_FILEBEAT_CONFIG = base64encode(templatefile("${path.module}/config/filebeat/filebeat.yml.tpl", {
      LOGGING_PROXY_IP = hpegl_metal_host.logz_bridge.0.connections.logging-network,
    })),
    TF_LOGSTASH_CONFIG = "",
    TF_LOGSTASH_LOGZIO_CONFIG = "",
  }) : null
}

# logging is enabled
module "logging_proxy_image" {
  count = var.enable_logging ? 1 : 0
  source = "./modules/d/linux_image"
  image_flavor = "ubuntu"
  image_version = "18.04"
}

module "logging_proxy_ssh_key" {
  count = var.enable_logging ? 1 : 0
  source = "./modules/r/ssh_key"
  name = var.logging_proxy_public_key_name
  public_key = var.logging_proxy_public_key
}

module "logging_network" {
  count = var.enable_logging ? 1 : 0
  source = "./modules/r/private_network"
  location = var.location
  name = "logging-network"
  description = "a dedicated network to stream logs"
  pool_name = "logging-network-ip-pool"
  pool_description = "logging network private network main pool"
  pool_ip_version = var.logging_network_pool_ip_version
  pool_base_ip = var.logging_network_pool_base_ip
  pool_cidr = var.logging_network_pool_cidr
  pool_gateway = null
  pool_dns = null
  pool_proxy = null
  pool_no_proxy = null
  pool_ntp = null
  sources = []
}

resource "hpegl_metal_host" "logz_bridge" {
  count = var.enable_logging ? 1 : 0
  name          = "logz-proxy-host"
  image         = module.logging_proxy_image.0.first_image
  machine_size  = var.logging_proxy_machine_size
  ssh           = [module.logging_proxy_ssh_key.0.id]
  networks      = ["Public", "Storage-Client", module.logging_network.0.name]
  network_route = "Public"
  location      = var.location
  description   = "Logz proxy server"
  user_data = var.enable_logging ? templatefile("${path.module}/cloud-init/config.yaml.tpl", {
    TF_LOG_COMPONENT = "logstash",
    TF_FILEBEAT_CONFIG = "",
    TF_LOGSTASH_CONFIG = base64encode(file("${path.module}/config/logstash/logstash.yml")),
    TF_LOGSTASH_LOGZIO_CONFIG = base64encode(templatefile("${path.module}/config/logstash/logzio.conf.tpl", {
      TF_LOGZIO_SHIP_TOKEN = var.logzio_ship_token,
      TF_LOGZIO_SERVICE_URL = var.logzio_service_url,
      TF_LOGZIO_SERVICE_PORT = var.logzio_service_port,
    }))
  }) : null
}
