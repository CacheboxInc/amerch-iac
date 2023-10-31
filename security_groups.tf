resource "ibm_is_security_group" "receiver-sg" {
  name           = "${var.unique_id}-receiver-sg"
  vpc            = ibm_is_vpc.dr-vpc.id
  resource_group = ibm_resource_group.default_rg.id
}