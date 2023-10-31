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

resource "ibm_is_vpc_address_prefix" "dr-vpc-prefix2" {
  cidr       = var.dr_vpc_prefix2
  name       = "${var.unique_id}-prefix2"
  vpc        = ibm_is_vpc.dr-vpc.id
  zone       = "${var.ibm_region}-2"
  is_default = true
  depends_on = [ibm_is_vpc.dr-vpc]
}

resource "ibm_is_vpc_address_prefix" "dr-vpc-prefix3" {
  cidr       = var.dr_vpc_prefix3
  name       = "${var.unique_id}-prefix3"
  vpc        = ibm_is_vpc.dr-vpc.id
  zone       = "${var.ibm_region}-3"
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

resource "ibm_is_subnet" "dr_subnet2" {
  name            = "${var.unique_id}-subnet2"
  vpc             = ibm_is_vpc.dr-vpc.id
  zone            = "${var.ibm_region}-2"
  ipv4_cidr_block = var.dr_subnet2
  resource_group  = ibm_resource_group.default_rg.id
  tags            = ["managedby:terraform"]
  depends_on      = [ibm_is_vpc_address_prefix.dr-vpc-prefix2]
}

resource "ibm_is_subnet" "dr_subnet3" {
  name            = "${var.unique_id}-subnet3"
  vpc             = ibm_is_vpc.dr-vpc.id
  zone            = "${var.ibm_region}-3"
  ipv4_cidr_block = var.dr_subnet3
  resource_group  = ibm_resource_group.default_rg.id
  tags            = ["managedby:terraform"]
  depends_on      = [ibm_is_vpc_address_prefix.dr-vpc-prefix3]
}


#----------------public GW--------------------#
resource "ibm_is_public_gateway" "PGW_zone1" {
  name           = "${var.unique_id}-pgw1"
  vpc            = ibm_is_vpc.dr-vpc.id
  zone           = "${var.ibm_region}-1"
  tags           = ["managedby:terraform"]
  resource_group = ibm_resource_group.default_rg.id
  //User can configure timeouts
  timeouts {
    create = "1m"
  }
}

#---------------public GW attachment-----------#
resource "ibm_is_subnet_public_gateway_attachment" "pgw_attachment1" {
  subnet         = ibm_is_subnet.dr_subnet1.id
  public_gateway = ibm_is_public_gateway.PGW_zone1.id
}


#--------------TG to classic-------------#
# resource "ibm_tg_gateway" "tg1"{
#         name           = "${var.unique_id}-tg"
#         location       = var.ibm_region
#         global         = true
#         resource_group =  ibm_resource_group.default_rg.id
#         tags            = ["managedby:terraform"]
# }  


# #---TG connections from PIO account--------#
# resource "ibm_tg_connection_action" "pio_tg_cross_connection_approval" {
#     #provider       = ibm.account2
#     gateway        =  var.cross_tg_id 
#     connection_id  = var.cross_tg_connection_id
#     action = "approve"
# }

