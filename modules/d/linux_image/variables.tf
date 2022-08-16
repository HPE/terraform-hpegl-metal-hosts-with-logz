variable "image_flavor" {
  description = "The Linux image flavor. Must be one of \"ubuntu\" or \"centos\""
  type = string
  validation {
    condition = var.image_flavor == "ubuntu" || var.image_flavor == "centos"
    error_message = "Supported values are: ubuntu and centos"
  }
}

variable "image_version" {
  description = "Name of the private network"
  type = string
}