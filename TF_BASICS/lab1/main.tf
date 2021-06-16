terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
}

# Configure the Docker provider
provider "docker" {}

# Find the latest Ubuntu precise image.
resource "docker_image" "grafanaImage" {
  name = "grafana/grafana"
}

# # Create a container
resource "docker_container" "grafana_container" {
  count = 2
  image = docker_image.grafanaImage.latest
  name  = "grafana_container-${count.index}"
  ports {
      external = var.ext_port[count.index]
      internal = var.int_port
  }
}

output "public_ip" {
    value = [ for x in docker_container.grafana_container : "${x.name} - ${x.ip_address}:${x.ports[0].external}" ]
}