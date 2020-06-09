variable "vm_name" {
  default = "centos"
}

variable "ext_addr" {
  default = "172.16.101"
}

variable "int_addr" {
  default = "10.10.10"
}

variable "vm_count" {
  default = 3
}

variable "ssh-pubkey" {
  default = "~/.ssh/id_rsa.pub"
}
