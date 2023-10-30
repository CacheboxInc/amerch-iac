resource "ibm_resource_group" "default_rg" {
  name = "DR"
  tags = null
}

resource "ibm_is_vpc" "dr-vpc" {
  name                      = "${var.unique_id}-dr-vpc"
  address_prefix_management = "manual"
  resource_group            = ibm_resource_group.default_rg.id
  tags                      = ["managedby:terraform"]

}

resource "ibm_is_vpc_address_prefix" "dr-vpc-prefix1" {
  cidr       = var.dr_vpc_prefix1
  name       = "${var.unique_id}-prefix1"
  vpc        = ibm_is_vpc.dr-vpc.id
  zone       = "${var.ibm_region}-1"
  is_default = true
  depends_on = [ibm_is_vpc.dr-vpc]
}

resource "ibm_is_subnet" "dr_subnet1" {
  name            = "${var.unique_id}-subnet1"
  vpc             = ibm_is_vpc.dr-vpc.id
  zone            = "${var.ibm_region}-1"
  ipv4_cidr_block = var.dr_subnet1
  resource_group  = ibm_resource_group.default_rg.id
  tags            = ["managedby:terraform"]
  depends_on      = [ibm_is_vpc_address_prefix.dr-vpc-prefix1]
}

#---TG connections from PIO account--------#
resource "ibm_tg_connection_action" "pio_tg_cross_connection_approval" {
    #provider       = ibm.account2
    gateway        =  var.cross_tg_id 
    connection_id  = var.cross_tg_connection_id
    action = "approve"
}

