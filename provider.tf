# Set-up for terraform >= v0.13
terraform {
  required_providers {
    hpegl = {
      source  = "hpe/hpegl"
      version = ">= 0.2.0"
    }
  }
}

provider "hpegl" {
  # Provide metal block if .gltform file is not being supplied outside of terraform
  metal {
    project_id = var.project_id
    rest_url   = var.rest_url
  }
}
