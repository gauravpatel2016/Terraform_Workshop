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