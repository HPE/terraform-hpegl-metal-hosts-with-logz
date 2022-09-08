# Example of creating a Metal host with Logz logging

This is an example of creating a Metal host that has external logging with Logz configured 

To run the example:
* Export relevant Authentication details as environment variables
* Update `variables.tf`, provide a `terraform.tfvars` file, or provide overrides on the command line
* Run with a command similar to
```
terraform apply \
    -var ="location=USA:Texas:AUSL2"
``` 

## Example output

```
  hosts_ips     = {
    host-0 = 192.168.0.1
  }
  logz_host_ips = {
    logging-proxy     = "logz-proxy-host"
    logging-proxy-ips = 192.168.0.25
  }

```

### Argument Reference

The following arguments are supported:

- `location` - Where the host is to be created in country:region:data-center style.
- `project_id` - GreenLake metal project id
- `rest_url` - GreenLake metal service url
- `prefix` - A prefix to be added to created resources
- `host_count` - Number of hosts to create. Not including logging proxy if logging is enabled
- `machine_size` - The machine size for the hosts
- `public_key_name` - The name of the ssh public key
- `public_key` - The content of the ssh public key

- `enable_logging` - Deploy and configure logging infrastructure for Logzio
- `logging_proxy_public_key_name` - The name of the ssh public key for the logging proxy
- `logging_proxy_public_key` - The content of the ssh public key for the logging proxy
- `logging_proxy_machine_size` - The machine size for the hosts
- `logzio_ship_token` - Logzio shipping token
- `logzio_service_url` - logzio service sub-account url
- `logzio_service_port` - logzio service port
- `logging_network_pool_ip_version` - The IP version of the logging network pool. One of IPv4 or IPv6
- `logging_network_pool_base_ip` - The network part of the main IP pool of the logging network. ex. 10.0.0.0
- `logging_network_pool_cidr` - The netmask part of the main IP pool of the logging network in CIDR notation. ex. /24

### Argument Reference - Data module

- `image_flavor` - The base operating system distribtion, e.g. "ubuntu"
- `image_version` - A specifc version of the image_flavor.

### Argument Reference - Resources module

#### Private Network 
- `location` - Textual representation of the resource location country:region:enter
- `name` - Name of the private network
- `description` - A description for the private network
- `pool_name` - Name of the private IP pool
- `pool_description` - A description for the network pool
- `pool_ip_version` - The IP version of the private network pool. One of IPv4 or IPv6
- `pool_base_ip` - The network part of the main IP pool of the private network. ex. 10.0.0.0
- `pool_cidr` - The netmask part of the main IP pool of the private network in CIDR notation. ex. /24
- `pool_gateway` - The gateway address of the main IP pool of the private network
- `pool_dns` - DNS server list for the main IP pool of the private network
- `pool_proxy` - The proxy for the network pool. ex. http://10.0.0.60:8080
- `pool_no_proxy` - String list of excluded hosts from the proxy. ex. 10.0.0.5,www.hpe.com
- `pool_ntp` - NTP server list for the network pool
- `sources` - IP ranges that are to be included in the pool within the base IP and netmask

#### SSH Key
- `name` - The name of the ssh public key
- `public_key` - The content of the ssh public key
