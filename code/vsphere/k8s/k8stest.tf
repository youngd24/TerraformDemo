###############################################################################
#
# k8stest.tf
#
# Test Kubernetes cluster shared settings
#
###############################################################################

provider "vsphere" {
  version        = "1.11.0"
  vsphere_server = var.vsphere_server
  user           = var.vsphere_username
  password       = var.vsphere_password 

  allow_unverified_ssl = "true"
}

data "vsphere_datacenter" "dc" {
  name = "PROD_DC"
}

data "vsphere_datastore" "datastore" {
  name          = "prod-store"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "PROD_CLUSTER"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "prod-network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "centos7-x86_64-stage1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

