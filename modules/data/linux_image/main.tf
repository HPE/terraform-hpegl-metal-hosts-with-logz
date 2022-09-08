data "hpegl_metal_available_images" "linux" {
  filter {
    name   = "flavor"
    values = ["(?i)${var.image_flavor}"] // case insensitive for Ubuntu or ubuntu etc.
  }
  filter {
    name   = "version"
    values = ["${var.image_version}*"] // all 18.04 image variants
  }
}
