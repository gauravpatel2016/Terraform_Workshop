variable "ext_port" {
  type = number
}

variable "int_port" {
  type    = number
  default = 1880

}

variable "container_count" {
  type    = number
  default = 1
}