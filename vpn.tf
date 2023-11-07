resource "ibm_is_ike_policy" "ike-policy" {
  name                     = "${var.unique_id}-ike-policy"
  resource_group           = ibm_resource_group.default_rg.id
  authentication_algorithm = "sha256" # Updated to SHA-256
  encryption_algorithm     = "aes256" # Stays the same, AES-256
  dh_group                 = 19       # Updated to DH-group 19
  ike_version              = 2        # Stays the same, IKEv2
  key_lifetime             = 86400    # Updated to 86400 seconds 
}

resource "ibm_is_ipsec_policy" "ipsec-policy" {
  name                     = "${var.unique_id}-ipsec-policy"
  resource_group           = ibm_resource_group.default_rg.id
  authentication_algorithm = "sha256"   # Updated to SHA-256
  encryption_algorithm     = "aes256"   # Stays the same, AES-256
  pfs                      = "group_19" # Updated to PFS with DH-group 19
  key_lifetime             = 10800      # Updated to 10800 seconds 
}


#-----------VPN GW in WDC1--------#
resource "ibm_is_vpn_gateway" "vpn-gw-zone1" {
  name   = "${var.unique_id}-vpn-gw-zone1"
  subnet = ibm_is_subnet.dr_subnet1.id
  # carefully select the subnet
  resource_group = ibm_resource_group.default_rg.id
  mode           = "policy"
}

#-----------VPN GW in WDC2--------#
resource "ibm_is_vpn_gateway" "vpn-gw-zone2" {
  name   = "${var.unique_id}-vpn-gw-zone2"
  subnet = ibm_is_subnet.dr_subnet2.id
  # carefully select the subnet
  resource_group = ibm_resource_group.default_rg.id
  mode           = "policy"
}

resource "ibm_is_vpn_gateway_connection" "conenection-from-dallas1" {
  name           = "${var.unique_id}-wdc-zone1-connection"
  vpn_gateway    = ibm_is_vpn_gateway.vpn-gw-zone1.id
  peer_address   = var.dal1_peer_vpngw_ip
  preshared_key  = var.passphrase_key
  local_cidrs    = [ibm_is_subnet.dr_subnet1.ipv4_cidr_block]
  peer_cidrs     = ["192.168.220.0/24", "192.168.222.0/24"]
  ike_policy     = ibm_is_ike_policy.ike-policy.id
  ipsec_policy   = ibm_is_ipsec_policy.ipsec-policy.id
  admin_state_up = true
}

resource "ibm_is_vpn_gateway_connection" "conenection-from-dallas2" {
  name           = "${var.unique_id}-wdc-zone2-connection"
  vpn_gateway    = ibm_is_vpn_gateway.vpn-gw-zone2.id
  peer_address   = var.dal2_peer_vpngw_ip
  preshared_key  = var.passphrase_key
  local_cidrs    = [ibm_is_subnet.dr_subnet2.ipv4_cidr_block]
  peer_cidrs     = ["192.168.221.0/24", "192.168.223.0/24"]
  ike_policy     = ibm_is_ike_policy.ike-policy.id
  ipsec_policy   = ibm_is_ipsec_policy.ipsec-policy.id
  admin_state_up = true
}



