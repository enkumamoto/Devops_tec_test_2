variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vm_name" {
  type    = string
  default = "bastion-vm"
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "admin_username" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "allowed_ssh_subnet" {
  type        = string
  description = "Subnet CIDR allowed to SSH (ex: AKS subnet)"
}
