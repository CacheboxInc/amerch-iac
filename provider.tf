terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.58.1"

    }
  }

  backend "s3" {
    bucket                      = "amerch-dr-terraform" //bucket name in which terraform state will stored
    key                         = "terraform.tfstate"   //name of the file where to store terraform state information in the bucket
    region                      = "us-east"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = false
    endpoint                    = "s3.us-east.cloud-object-storage.appdomain.cloud"
  }
}

provider "ibm" {
  region           = "us-east"
  ibmcloud_api_key = var.ibmcloud_api_key
}