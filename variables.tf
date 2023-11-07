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
  default = "bx2-2x8"
}

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