variable "ibmcloud_api_key" {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources\n Please enter the IBM IAM API key"
  type        = string

}

variable "ibm_region" {
  description = "IBM Cloud region where all resources will be deployed"
  type        = string
  default     = "us-east"
}

variable "unique_id" {
  default = "amerch"
}

variable "generation" {
  description = "generation for VPC. Can be 1 or 2"
  type        = number
  default     = 2
}

variable "dr_vpc_prefix1" {
  default = "172.29.1.0/24"
}

variable "dr_vpc_prefix2" {
  default = "172.29.2.0/24"
}

variable "dr_vpc_prefix3" {
  default = "172.29.3.0/24"
}

variable "dr_subnet1" {
  default = "172.29.1.0/24"
}

variable "dr_subnet2" {
  default = "172.29.2.0/24"
}

variable "dr_subnet3" {
  default = "172.29.3.0/24"
}

variable "cross_tg_id" {
  default = "c78df06b-0f41-43da-8bd6-8da2925ba4c4"
}

variable "cross_tg_connection_id" {
  default = "b662407b-770d-4dea-abe7-fa2095376e8a"
}

variable "dr_reciver_host_profile" {
  default = "bx2-16x64"
}

#############################
#######ESXI variables########

variable "vmw_host_profile" {
  #default = "bx2d-metal-96x384" //8 disks
  #default = "bx2-metal-96x384" //1 disk
  #default = "bx2-metal-96x384"
  #default = "cx2-metal-96x192"
  default = "mx2d-metal-96x768" //8 disks
  #default = "mx2-metal-96x768" //1 disk
}

variable "esxi_image" {
  description = "Base ESXI image name, terraform will find the latest available image id."
  default     = "esxi-7-byol"
  type        = string
}

variable "esxi_image_name" {
  description = "Use a specific ESXI image version to use for the hosts to override the latest by name."
  default     = "ibm-esxi-7-0u3l-21424296-amd64-2"
  type        = string
}

variable "host_vlan_id" {
  description = "VLAN ID for host network"
  default     = 0
  type        = number
}

variable "mgmt_vlan_id" {
  description = "VLAN ID for management network"
  default     = 100
  type        = number
}

variable "mgmt_vlan_name" {
  default = "vlan-nic-vcenter"
  type    = string

}

variable "vcenter_password" {
  description = "Define a common password for all elements. Optional, leave empty to get random passwords."
  default     = ""
  type        = string
}


variable "esxi_password" {
  description = "Define a common password for all elements. Optional, leave empty to get random passwords."
  default     = ""
  type        = string
}

variable "vmw_host_list" {
  default = 1

}

variable "esxi-hostname" {
  default = "172.29.1.4"
}

variable "esxi-username" {
  default = "root"
}

variable "esxi-password" {
  default = "AmerchIO@123"
}

variable "esxi-deployment-nw" {
  default = "pg-mgmt"

}

variable "esxi-datastore" {
  default = "datastore1"
}

variable "vcenter-ip" {
  default = "172.29.1.5"
}

variable "vcenter-subnet-prefix" {
  default = "24"
}

variable "vcenter-gw" {
  default = "172.29.1.1"
}

variable "vcenter-password" {
  default = "AmerchIO@123"
}

variable "vcenter-domain_name" {
  default = "primaryio.cloud"
}

variable "esxi-hostname-fqdn" {
  default = "esxi.primaryio.cloud"

}

variable "vm-network1-vlan-id" {
  description = "VLAN ID for vm network"
  default     = 101
  type        = number
}

variable "vm-network1-vlan-name" {
  default = "vlan-nic-vm1"
  type    = string
}

variable "vlan-nic-dhcp-server-name" {
  default = "vlan-nic-dhcp-server"
}

variable "vlan-nic-dhcp-server-ip" {
  default = "172.29.1.12"
}

####################################
#######end of ESXI variables########

variable "dal1_peer_vpngw_ip" {
  default = "52.118.186.49"
}

variable "dal2_peer_vpngw_ip" {
  default = "150.239.171.84"
}

variable "passphrase_key" {
  default = "15c585864a074a98936fdc346e6fd8ed357ebe0db7b00f0c4edd5bbd"
}

variable "dal1_peer_cidrs" {
  default = ["192.168.220.0/24", "192.168.222.0/24"]
}

variable "dal2_peer_cidrs" {
  default = ["192.168.221.0/24", "192.168.223.0/24"]
}