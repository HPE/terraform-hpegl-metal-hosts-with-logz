output "first_image" {
  value = format("%s@%s",data.hpegl_metal_available_images.linux.images[0].flavor,data.hpegl_metal_available_images.linux.images[0].version)
}
