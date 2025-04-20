
terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.11.0"
    }
  }
}

# Configure the VCD Provider
provider "vcd" {
  user = "none" 
  password  = "none"
  org = var.vcd_org
  vdc = var.vcd_vdc
  url = var.vcd_url
  auth_type = "api_token"
  api_token = var.vcd_token
}
