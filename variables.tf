variable "environment" {
  type = string
}

variable "ingress" {}

variable "name" {
  type = string
}

variable "port" {
  type = number
}

variable "tags" {
  type = map(string)
}
