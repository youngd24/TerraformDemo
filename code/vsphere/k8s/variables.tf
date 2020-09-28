###############################################################################
#
# variables.tf
#
# Terraform vars
#
###############################################################################

variable "vsphere_server" {
    type = string
    default = "vcenter.prod.domain"
}

variable "vsphere_username" {
    type = string
    default = "automation"
}

variable "vsphere_password" {
    type = string
    default = ""
}
