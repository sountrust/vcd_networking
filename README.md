# 🌐 Terraform Networking Module for VCloudDirector

This module provisions NSX-T-based network and firewall infrastructure for VCloudDirector Kubernetes clusters deployed on vCloud Director (vCD). It handles everything from routed network setup to custom application port profiles and edge firewall rules.

---

## 📌 Purpose

The `network` module is a standalone and reusable Terraform component designed to:

- Create routed organization VDC networks for Kubernetes clusters
- Define NSX-T IP sets for public and internal subnet grouping
- Register application port profiles for use in NAT/firewall rules
- Open firewall rules to allow Kubernetes-specific traffic (SSH, HTTP(S), K8s API, NodePorts)
- Provide consistent network policy enforcement across all environments (dev, staging, temp)

---

## ⚙️ Usage

To use this module inside a root Terraform project:

```hcl
module "network" {
  source = "./network"

  vcd_token              = var.vcd_token
  vcd_org                = var.vcd_org
  vcd_url                = var.vcd_url
  vcd_vdc_group          = var.vcd_vdc_group
  vcd_vdc                = var.vcd_vdc
  vcd_nsxt_edgegateway   = var.vcd_nsxt_edgegateway
  vcd_cluster_name       = var.vcd_cluster_name
}
```

---

## 🔐 Required Variables

| Name                    | Description                         |
|-------------------------|-------------------------------------|
| `vcd_token`             | vCD API token (sensitive)           |
| `vcd_org`               | vCD organization name               |
| `vcd_url`               | vCD API endpoint URL                |
| `vcd_vdc_group`         | vCD Virtual Datacenter Group name   |
| `vcd_vdc`               | Target vCD VDC                      |
| `vcd_nsxt_edgegateway`  | NSX-T edge gateway name             |
| `vcd_cluster_name`      | Cluster name for labeling resources |

---

## 🧱 Resources Created

### 🔐 NSX-T IP Sets

- `public_setIp` – External IPs allowed for public exposure
- `cluster_dev_IpSet`, `cluster_temp_IpSet`, `cluster_staging_IpSet` – Internal networks for each environment

### 🌐 Routed Org Network

- `nsxt_temp` – VDC network created with a static IP pool for the temporary environment

### 🔥 Application Port Profiles

Profiles used in firewall/NAT rules, including:

- Default: HTTP, HTTPS, SSH
- Custom:
  - `CUSTOM_SSH`: SSH ranges per environment
  - `kubernetes`, `kubernetes_environment_port`: API server
  - `http-nodeport`, `https-nodeport`: NodePort exposure
  - `http-environment-port`, `https-environment-port`: Env-aware redirections

### 🛡️ Firewall Rules

- `common_ports_open_edge`: Open public-facing ports on edge
- `IPV4_cluster_rules`: Allow inter-cluster traffic between internal subnets

---

## 🧪 Example Output

Use the routed network `nsxt_temp` for VM attachments:

```hcl
network_name = vcd_network_routed_v2.temp_network.name
```

---

## 🧹 Cleanup

To tear down:

```bash
terraform destroy
```

Be cautious if used across environments.

---

## 🧭 Notes

- Scoped to support dev, temp, and staging clusters
- CIDRs and IP pools must match cluster plan
- Application profiles scoped to `TENANT` unless reused from `SYSTEM`

---

## 🛠️ Maintainer

**Sountrust DevOps**  
📧 paul@sountrust.com
