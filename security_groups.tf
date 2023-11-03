resource "ibm_is_security_group" "receiver-sg" {
  name           = "${var.unique_id}-receiver-sg"
  vpc            = ibm_is_vpc.dr-vpc.id
  resource_group = ibm_resource_group.default_rg.id
}

resource "ibm_is_security_group_rule" "receiver-sg-rule1" {
  group     = ibm_is_security_group.receiver-sg.id
  direction = "inbound"
  remote    = "192.168.220.5/32"
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