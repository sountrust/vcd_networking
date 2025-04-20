
# Getting http from MonacoCloud application profiles for nat AND firewall rules
data "vcd_nsxt_app_port_profile" "http" {

  scope = "SYSTEM"
  name  = "HTTP"
}

# Getting https from MonacoCloud application profiles for nat AND firewall rules
data "vcd_nsxt_app_port_profile" "https" {

  scope = "SYSTEM"
  name  = "HTTPS"
}

# Getting SSH from MonacoCloud application profiles for nat AND firewall rules
data "vcd_nsxt_app_port_profile" "ssh" {

  scope = "SYSTEM"
  name  = "SSH"
}

# Getting ssh rom MonacoCloud application profiles for nat AND firewall rules
resource "vcd_nsxt_app_port_profile" "custom_ssh" {

  name        = "CUSTOM_SSH"
  description = "Application port profile for custom ssh connection"

  scope = "TENANT"

  app_port {
    protocol = "TCP"
    port = ["dev_ssh_port_range", "staging_ssh_port_range", "prod_ssh_port_range", "other_ssh_port_range"]
  }
}

# Creating custom K8s application profiles for API in nat rules
resource "vcd_nsxt_app_port_profile" "K8s" {

  name        = "kubernetes"
  description = "Application port profile for K8S API connection"

  scope = "TENANT"

  app_port {
    protocol = "TCP"
    port = ["6443"]
  }
}

# Creating custom K8s application profiles for API in firewall rules
resource "vcd_nsxt_app_port_profile" "K8s_environment_port" {

  name        = "kubernetes_environment_port"
  description = "Application port profile for K8S API connection in firawall rule"

  scope = "TENANT"

  app_port {
    protocol = "TCP"
    port = ["5443", "6443", "7443"]
  }
}

# Creating custom http traffic to node port application profiles in firewall rules
resource "vcd_nsxt_app_port_profile" "http_nodeport" {

  name        = "http-nodeport"
  description = "Application port profile for http nodeport redirection"

  scope = "TENANT"

  app_port {
    protocol = "TCP"
    port = ["30080"]
  }
}

# Creating custom https traffic to node port application profiles in firewall rules
resource "vcd_nsxt_app_port_profile" "https_nodeport" {

  name        = "https-nodeport"
  description = "Application port profile for https nodeport redirection"

  scope = "TENANT"

  app_port {
    protocol = "TCP"
    port = ["30443"]
  }
}

# Creating custom http traffic to external port application profiles in firewall rules
resource "vcd_nsxt_app_port_profile" "http_environment_port" {

  name        = "http-environment-port"
  description = "Application port profile for http redirection in firewall rule"

  scope = "TENANT"

  app_port {
    protocol = "TCP"
    port = ["8080", "8180"]
  }
}

# Creating custom https traffic to external port application profiles in firewall rules
resource "vcd_nsxt_app_port_profile" "https_environment_port" {

  name        = "https-environment-port"
  description = "Application port profile for https redirection in firewall rule"

  scope = "TENANT"

  app_port {
    protocol = "TCP"
    port = ["8443", "8543"]
  }
}
