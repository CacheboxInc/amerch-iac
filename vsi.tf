data "ibm_is_image" "custom_image" {
  name = "dr-receiver"
}

resource "ibm_is_instance" "receiver-prod1" {
  name           = "${var.unique_id}1-receiver-server1"
  vpc            = ibm_is_vpc.dr-vpc.id
  zone           = "${var.ibm_region}-1"
  resource_group = ibm_resource_group.default_rg.id
  keys           = [ibm_is_ssh_key.prod_dal_jumphost_ssh_key.id]
  image          = data.ibm_is_image.custom_image.id
  depends_on     = [ibm_is_security_group.receiver-sg]
  profile        = var.dr_reciver_host_profile
  user_data      = <<-EOF
                #!/bin/bash
                systemctl start drsrv
                EOF
  boot_volume {
    name = "${var.unique_id}1-receiver-server-bv"
    size = 250
    tags = []
  }
  primary_network_interface {
    name            = "${var.unique_id}1-receiver-eth0"
    subnet          = ibm_is_subnet.dr_subnet1.id
    security_groups = [ibm_is_security_group.receiver-sg.id]
  }
}

resource "ibm_is_instance" "receiver-prod2" {
  name           = "${var.unique_id}1-receiver-server2"
  vpc            = ibm_is_vpc.dr-vpc.id
  zone           = "${var.ibm_region}-1"
  resource_group = ibm_resource_group.default_rg.id
  keys           = [ibm_is_ssh_key.prod_dal_jumphost_ssh_key.id]
  image          = data.ibm_is_image.custom_image.id
  depends_on     = [ibm_is_security_group.receiver-sg]
  profile        = var.dr_reciver_host_profile
  user_data      = <<-EOF
                #!/bin/bash
                systemctl start drsrv
                EOF
  boot_volume {
    name = "${var.unique_id}1-receiver-server-bv2"
    size = 250
    tags = []
  }
  primary_network_interface {
    name            = "${var.unique_id}1-receiver-eth0-2"
    subnet          = ibm_is_subnet.dr_subnet1.id
    security_groups = [ibm_is_security_group.receiver-sg.id]
  }
}

resource "ibm_is_instance" "receiver-prod5" {
  name           = "${var.unique_id}1-receiver-server5"
  vpc            = ibm_is_vpc.dr-vpc.id
  zone           = "${var.ibm_region}-1"
  resource_group = ibm_resource_group.default_rg.id
  keys           = [ibm_is_ssh_key.prod_dal_jumphost_ssh_key.id]
  image          = data.ibm_is_image.custom_image.id
  depends_on     = [ibm_is_security_group.receiver-sg]
  profile        = var.dr_reciver_host_profile
  user_data      = <<-EOF
                #!/bin/bash
                systemctl start drsrv
                EOF
  boot_volume {
    name = "${var.unique_id}1-receiver-server-bv5"
    size = 250
    tags = []
  }
  primary_network_interface {
    name            = "${var.unique_id}1-receiver-eth0-5"
    subnet          = ibm_is_subnet.dr_subnet1.id
    security_groups = [ibm_is_security_group.receiver-sg.id]
  }
}

resource "ibm_is_instance" "receiver-prod3" {
  name           = "${var.unique_id}1-receiver-server3"
  vpc            = ibm_is_vpc.dr-vpc.id
  zone           = "${var.ibm_region}-2"
  resource_group = ibm_resource_group.default_rg.id
  keys           = [ibm_is_ssh_key.prod_dal_jumphost_ssh_key.id]
  image          = data.ibm_is_image.custom_image.id
  depends_on     = [ibm_is_security_group.receiver-sg]
  profile        = var.dr_reciver_host_profile
  user_data      = <<-EOF
                #!/bin/bash
                systemctl start drsrv
                EOF
  boot_volume {
    name = "${var.unique_id}1-receiver-server-bv3"
    size = 250
    tags = []
  }
  primary_network_interface {
    name            = "${var.unique_id}1-receiver-eth0-3"
    subnet          = ibm_is_subnet.dr_subnet2.id
    security_groups = [ibm_is_security_group.receiver-sg.id]
  }
}

resource "ibm_is_instance" "receiver-prod4" {
  name           = "${var.unique_id}1-receiver-server4"
  vpc            = ibm_is_vpc.dr-vpc.id
  zone           = "${var.ibm_region}-2"
  resource_group = ibm_resource_group.default_rg.id
  keys           = [ibm_is_ssh_key.prod_dal_jumphost_ssh_key.id]
  image          = data.ibm_is_image.custom_image.id
  depends_on     = [ibm_is_security_group.receiver-sg]
  profile        = var.dr_reciver_host_profile
  user_data      = <<-EOF
                #!/bin/bash
                systemctl start drsrv
                EOF
  boot_volume {
    name = "${var.unique_id}1-receiver-server-bv4"
    size = 250
    tags = []
  }
  primary_network_interface {
    name            = "${var.unique_id}1-receiver-eth0-4"
    subnet          = ibm_is_subnet.dr_subnet2.id
    security_groups = [ibm_is_security_group.receiver-sg.id]
  }
}


