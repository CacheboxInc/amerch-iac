data "ibm_is_images" "os_images" {
  visibility = "public"
}

locals {
  os_images_filtered_esxi = [
    for image in data.ibm_is_images.os_images.images :
    image if((image.os == var.esxi_image) && (image.status == "available"))
  ]
}

data "ibm_is_image" "vmw_esx_image" {
  name = var.esxi_image_name == "" ? local.os_images_filtered_esxi[0].name : var.esxi_image_name
}

resource "ibm_is_bare_metal_server" "esx_host" {
  profile = var.vmw_host_profile
  user_data = templatefile("./setup-esxi.tftpl", {
    esxi-hostname-fqdn  = var.esxi-hostname-fqdn
    mgmt_vlan_id        = var.mgmt_vlan_id
    vm-network1-vlan-id = var.vm-network1-vlan-id
    esxi-password       = var.esxi-password
    esxi-deployment-nw  = var.esxi-deployment-nw
    ibmcloud_api_key    = var.ibmcloud_api_key
  })
  name           = "${var.unique_id}-esxi01"
  resource_group = ibm_resource_group.default_rg.id
  image          = data.ibm_is_image.vmw_esx_image.id
  zone           = "${var.ibm_region}-1"
  keys           = [ibm_is_ssh_key.prod_dal_jumphost_ssh_key.id]

  primary_network_interface {
    # pci 1
    subnet                    = ibm_is_subnet.dr_subnet1.id
    allowed_vlans             = ["100", "101"]
    name                      = "pci-vmnic0-vmk0"
    security_groups           = [ibm_is_security_group.esxi-sg.id]
    enable_infrastructure_nat = true
  }

  #tags = var.vmw_tags

  vpc = ibm_is_vpc.dr-vpc.id
  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }

  lifecycle {
    ignore_changes = [user_data, image]
  }
}

resource "ibm_is_bare_metal_server_network_interface" "esx_host_vcenter" {
  bare_metal_server        = ibm_is_bare_metal_server.esx_host.id
  subnet                   = ibm_is_subnet.dr_subnet1.id
  name                     = var.mgmt_vlan_name
  security_groups          = [ibm_is_security_group.esxi-sg.id]
  allow_ip_spoofing        = false
  vlan                     = var.mgmt_vlan_id
  allow_interface_to_float = true
  depends_on               = [ibm_is_bare_metal_server.esx_host]
}

resource "ibm_is_bare_metal_server_network_interface" "esx_host_vm1" {
  bare_metal_server        = ibm_is_bare_metal_server.esx_host.id
  subnet                   = ibm_is_subnet.dr_subnet1.id
  name                     = var.vm-network1-vlan-name
  security_groups          = [ibm_is_security_group.esxi-sg.id]
  allow_ip_spoofing        = false
  vlan                     = var.vm-network1-vlan-id
  allow_interface_to_float = true
  depends_on               = [ibm_is_bare_metal_server.esx_host]
}


resource "ibm_is_bare_metal_server_network_interface" "dhcp-server" {
  bare_metal_server        = ibm_is_bare_metal_server.esx_host.id
  subnet                   = ibm_is_subnet.dr_subnet1.id
  name                     = var.vlan-nic-dhcp-server-name
  security_groups          = [ibm_is_security_group.esxi-sg.id]
  allow_ip_spoofing        = false
  vlan                     = var.vm-network1-vlan-id
  allow_interface_to_float = true
  depends_on               = [ibm_is_bare_metal_server.esx_host]
  primary_ip {
    address = var.vlan-nic-dhcp-server-ip
  }
}