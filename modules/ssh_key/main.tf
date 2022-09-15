// (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP

resource "hpegl_metal_ssh_key" "this" {
  name       = var.name
  public_key = var.public_key
}