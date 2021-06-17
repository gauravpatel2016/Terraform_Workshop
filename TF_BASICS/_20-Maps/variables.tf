variable "env" {
  type    = string
  default = "dev"
}

variable "image" {
  type        = map(any)
  description = "Image for container"
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "ext_port" {
  type = list(any)
}

variable "int_port" {
  type    = number
  default = 1880
}

locals {
  container_count = length(var.ext_port)
}