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

variable "dr_subnet1" {
  default = "172.29.1.0/24"
}