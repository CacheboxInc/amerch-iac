resource "ibm_is_lb" "dr-receivers" {
  name            = "${var.unique_id}-dr-receivers-alb"
  subnets         = [ibm_is_subnet.dr_subnet1.id, ibm_is_subnet.dr_subnet2.id, ibm_is_subnet.dr_subnet3.id]
  tags            = ["env:prod", "managedby:terraform"]
  security_groups = [ibm_is_security_group.receiver-alb-sg.id]
  resource_group  = ibm_resource_group.default_rg.id
  type            = "private"
}


resource "ibm_is_lb_listener" "alb_listener" {
  lb           = ibm_is_lb.dr-receivers.id
  port         = "7100"
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.dr-receivers.id
  depends_on   = [ibm_is_lb.dr-receivers, ibm_is_lb_pool.dr-receivers]
}


resource "ibm_is_lb_pool" "dr-receivers" {
  lb             = ibm_is_lb.dr-receivers.id
  name           = "${var.unique_id}-dr-receivers"
  algorithm      = "least_connections"
  protocol       = "tcp"
  health_delay   = 5
  health_retries = 2
  health_timeout = 2
  health_type    = "tcp"
}

resource "ibm_is_lb_pool_member" "dr-receivers_member_1" {
  lb             = ibm_is_lb.dr-receivers.id
  pool           = ibm_is_lb_pool.dr-receivers.id
  port           = 7100
  target_address = ibm_is_instance.receiver-prod1.primary_network_interface.0.primary_ip.0.address
}

# resource "ibm_is_lb_pool_member" "dr-receivers_member_2" {
#   lb             = ibm_is_lb.dr-receivers.id
#   pool           = ibm_is_lb_pool.dr-receivers.id
#   port           = 7100
#   target_address = ibm_is_instance.receiver-prod2.primary_network_interface.0.primary_ip.0.address
# }

resource "ibm_is_lb_pool_member" "dr-receivers_member_5" {
  lb             = ibm_is_lb.dr-receivers.id
  pool           = ibm_is_lb_pool.dr-receivers.id
  port           = 7100
  target_address = ibm_is_instance.receiver-prod5.primary_network_interface.0.primary_ip.0.address
}

