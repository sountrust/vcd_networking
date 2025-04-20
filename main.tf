# Data source
data "vcd_vdc_group" "main" {
  name = var.vcd_vdc_group
}

# Existing edgegateway declaration
data "vcd_nsxt_edgegateway" "existing" {
  owner_id = data.vcd_vdc_group.main.id
  name = var.vcd_nsxt_edgegateway
}

# Create a new network in organization VDC defined in branch_name folder
resource "vcd_network_routed_v2" "temp_network" {
  name = "nsxt_temp"
  description = "My routed Org VDC network backed by NSX-T"

  edge_gateway_id = data.vcd_nsxt_edgegateway.existing.id

  gateway = "vcd_nsxt_edgegateway"

  prefix_length = 24

  static_ip_pool {
    start_address = "start_address"
    end_address = "end_address"
  }
}

