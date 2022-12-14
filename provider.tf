// (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP
# Set-up for terraform >= v0.13
terraform {
  required_providers {
    hpegl = {
      source  = "hpe/hpegl"
      version = ">= 0.3.3"
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
