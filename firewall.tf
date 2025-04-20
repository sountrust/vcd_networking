# Edgegateway firewall rules 
resource "vcd_nsxt_firewall" "cluster_waf" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.existing.id 
  # to open communication within edge for SSH, HTTP, HTTPS and Kubernetes
  rule {
    action = "ALLOW"
    name = "common_ports_open_edge"
    direction = "IN"
    destination_ids = [vcd_nsxt_ip_set.public_setIp.id]
    ip_protocol = "IPV4"
    app_port_profile_ids = [vcd_nsxt_app_port_profile.custom_ssh.id, data.vcd_nsxt_app_port_profile.http.id, data.vcd_nsxt_app_port_profile.https.id, vcd_nsxt_app_port_profile.http_environment_port.id, vcd_nsxt_app_port_profile.https_environment_port.id, vcd_nsxt_app_port_profile.K8s_environment_port.id]
  }
  # to open IPV4 communication on clusters' ip_set 
  rule {
    action = "ALLOW"
    name = "IPV4_cluster_rules"
    direction = "IN_OUT"
    source_ids = [vcd_nsxt_ip_set.cluster_temp_IpSet.id, vcd_nsxt_ip_set.cluster_dev_IpSet.id, vcd_nsxt_ip_set.cluster_staging_IpSet.id]
    ip_protocol = "IPV4"
  }
}

# Ip set refering to public ip
resource "vcd_nsxt_ip_set" "public_setIp" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.existing.id 

  name = "public_setIp"
  description = "IP Set containing IPv4 and IPv6 ranges"

  ip_addresses = ["public_ip"]
}

# Ip set refering to kubernetes cluster_network
resource "vcd_nsxt_ip_set" "cluster_temp_IpSet" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.existing.id

  name = "cluster_temp_IpSet"
  description = "IP Set containing IPv4 and IPv6 ranges"

  ip_addresses = [
    "kubernetes_cluster_network"
  ]
}

# Ip set refering to kubernetes dev cluster_network
resource "vcd_nsxt_ip_set" "cluster_dev_IpSet" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.existing.id

  name = "cluster_dev_IpSet"
  description = "IP Set containing IPv4 and IPv6 ranges"

  ip_addresses = [
    "dev_kubernetes_cluster_network"
  ]
}

# Ip set refering to kubernetes staging cluster_network
resource "vcd_nsxt_ip_set" "cluster_staging_IpSet" {
  edge_gateway_id = data.vcd_nsxt_edgegateway.existing.id

  name = "cluster_staging_IpSet"
  description = "IP Set containing IPv4 and IPv6 ranges"

  ip_addresses = [
    "staging_kubernetes_cluster_network"
  ]
}

