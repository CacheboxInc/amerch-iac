resource "ibm_is_security_group" "receiver-sg" {
  name           = "${var.unique_id}-receiver-sg"
  vpc            = ibm_is_vpc.dr-vpc.id
  resource_group = ibm_resource_group.default_rg.id
}

resource "ibm_is_security_group_rule" "receiver-sg-rule1" {
  group     = ibm_is_security_group.receiver-sg.id
  direction = "inbound"
  remote    = "192.168.220.0/24"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "receiver-sg-rule2" {
  group     = ibm_is_security_group.receiver-sg.id
  direction = "inbound"
  remote    = ibm_is_security_group.receiver-alb-sg.id
  tcp {
    port_min = 7100
    port_max = 7100
  }
}

resource "ibm_is_security_group_rule" "receiver-sg-rule3" {
  group     = ibm_is_security_group.receiver-sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  # tcp {
  #   port_min = 1
  #   port_max = 65535
  # }
}

resource "ibm_is_security_group" "receiver-alb-sg" {
  name           = "${var.unique_id}-receiver-alb-sg"
  vpc            = ibm_is_vpc.dr-vpc.id
  resource_group = ibm_resource_group.default_rg.id
}

resource "ibm_is_security_group_rule" "receiver-alb-sg-rule-10-87-0-0" {
  group     = ibm_is_security_group.receiver-alb-sg.id
  direction = "inbound"
  remote    = "10.87.0.0/16"
  tcp {
    port_min = 7100
    port_max = 7100
  }
}

resource "ibm_is_security_group_rule" "receiver-alb-sg-rule-10-184-0-0" {
  group     = ibm_is_security_group.receiver-alb-sg.id
  direction = "inbound"
  remote    = "10.184.0.0/16"
  tcp {
    port_min = 7100
    port_max = 7100
  }
}

resource "ibm_is_security_group_rule" "receiver-alb-sg-rule-10-185-0-0" {
  group     = ibm_is_security_group.receiver-alb-sg.id
  direction = "inbound"
  remote    = "10.185.0.0/16"
  tcp {
    port_min = 7100
    port_max = 7100
  }
}

resource "ibm_is_security_group_rule" "receiver-alb-sg-rule-10-122-112-0" {
  group     = ibm_is_security_group.receiver-alb-sg.id
  direction = "inbound"
  remote    = "10.122.112.0/24"
  tcp {
    port_min = 7100
    port_max = 7100
  }
}

resource "ibm_is_security_group_rule" "receiver-alb-sg-rule1" {
  group     = ibm_is_security_group.receiver-alb-sg.id
  direction = "inbound"
  remote    = "10.0.0.0/8"
  tcp {
    port_min = 7100
    port_max = 7100
  }
}

resource "ibm_is_security_group_rule" "receiver-alb-sg-rule2" {
  group     = ibm_is_security_group.receiver-alb-sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

#------------------ESXi SG----------------#
resource "ibm_is_security_group" "esxi-sg" {
  name           = "${var.unique_id}-esxi-sg"
  vpc            = ibm_is_vpc.dr-vpc.id
  resource_group = ibm_resource_group.default_rg.id
}

resource "ibm_is_security_group_rule" "ingress_esxi_prod_dal_jumphost_public" {
  group     = ibm_is_security_group.esxi-sg.id
  direction = "inbound"
  remote    = "150.240.163.91/32"
}

resource "ibm_is_security_group_rule" "ingress_esxi_prod_dal_jumphost_private" {
  group     = ibm_is_security_group.esxi-sg.id
  direction = "inbound"
  remote    = "192.168.220.0/24"
}

resource "ibm_is_security_group_rule" "ingress_esxi_internal_all" {
  group     = ibm_is_security_group.esxi-sg.id
  direction = "inbound"
  remote    = "10.0.0.0/8"
}

resource "ibm_is_security_group_rule" "ingress__esxi_vpc1_all" {
  group     = ibm_is_security_group.esxi-sg.id
  direction = "inbound"
  remote    = var.dr_vpc_prefix1
}

resource "ibm_is_security_group_rule" "ingress__esxi_vpc2_all" {
  group     = ibm_is_security_group.esxi-sg.id
  direction = "inbound"
  remote    = var.dr_vpc_prefix2
}

resource "ibm_is_security_group_rule" "ingress__esxi_vpc3_all" {
  group     = ibm_is_security_group.esxi-sg.id
  direction = "inbound"
  remote    = var.dr_vpc_prefix3
}

# allow all outbound network traffic 
resource "ibm_is_security_group_rule" "egress_all_esxi" {
  group     = ibm_is_security_group.esxi-sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}