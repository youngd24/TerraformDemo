###############################################################################
#
# k8stst03.tf
#
###############################################################################

resource "vsphere_virtual_machine" "k8stst03" {
  name             = "k8stst03"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  folder = "k8s/Test"

  num_cpus = 2
  memory   = 4096
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  # OS Disk
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "k8stst03"
        domain    = "prod.domain"
      }

      network_interface {
        ipv4_address = "x.x.x.x"
        ipv4_netmask = 24
      }

      ipv4_gateway = "x.x.x.x"

      dns_server_list = ["x.x.x.x", "x.x.x.x"]
      dns_suffix_list = ["prod.domain"]
    }
  }
}
