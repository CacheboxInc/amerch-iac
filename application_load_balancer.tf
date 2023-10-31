resource "ibm_is_lb" "dr-receivers" {
  name            = "dr-receivers"
  subnets         = ["dr_subnet1", "dr_subnet2", "dr_subnet3"]
  security_groups = ibm_is_security_group.receiver-sg.id
}

resource "ibm_is_lb_pool" "dr-receivers" {
  lb             = ibm_is_lb.dr-receivers.id
  name           = "dr-receivers"
  algorithm      = "least_connections"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 2
  health_timeout = 2
  health_type    = "tcp"
}

resource "ibm_is_lb_pool_member" "dr-receivers_member_1" {
  lb             = ibm_is_lb.dr-receivers.id
  pool           = ibm_is_lb_pool.dr-receivers_pool.id
  port           = 7100
  target_address = "172.29.1.6"
}

resource "ibm_is_lb_pool_member" "dr-receivers_member_2" {
  lb             = ibm_is_lb.dr-receivers.id
  pool           = ibm_is_lb_pool.dr-receivers_pool.id
  port           = 7100
  target_address = "172.29.2.4"
}

resource "ibm_is_lb_pool_member" "dr-receivers_member_3" {
  lb             = ibm_is_lb.dr-receivers.id
  pool           = ibm_is_lb_pool.dr-receivers_pool.id
  port           = 7100
  target_address = "172.29.3.4"
}

