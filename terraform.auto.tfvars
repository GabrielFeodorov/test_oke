

region = "eu-frankfurt-1"


# general oci parameters


# networking
create_vcn               = true
assign_dns               = true
lockdown_default_seclist = true
vcn_cidrs                = ["10.0.0.0/16"]
vcn_dns_label            = "oke"
vcn_name                 = "oke"

# Subnets
subnets = {
  bastion  = { newbits = 13, netnum = 0, dns_label = "bastion", create = "always" }
  operator = { newbits = 13, netnum = 1, dns_label = "operator", create = "always" }
  cp       = { newbits = 13, netnum = 2, dns_label = "cp", create = "always" }
  int_lb   = { newbits = 11, netnum = 16, dns_label = "ilb", create = "always" }
  pub_lb   = { newbits = 11, netnum = 17, dns_label = "plb", create = "always" }
  workers  = { newbits = 2, netnum = 1, dns_label = "workers", create = "always" }
  pods     = { newbits = 2, netnum = 2, dns_label = "pods", create = "always" }
}

# bastion
create_bastion        = true
bastion_allowed_cidrs = ["0.0.0.0/0"]
bastion_user          = "opc"

# operator
create_operator      = true
operator_install_k9s = true


# iam
create_iam_operator_policy = "always"
create_iam_resources       = true

create_iam_tag_namespace = false // true/*false
create_iam_defined_tags  = false // true/*false
tag_namespace            = "oke"
use_defined_tags         = false // true/*false

# cluster
create_cluster                    = true
cluster_name                      = "oke"
cluster_type                      = "enhanced"
control_plane_is_public           = true
assign_public_ip_to_control_plane = true
cni_type                          = "OCI_VCN_IP_NATIVE"
kubernetes_version                = "v1.32.1"
oidc_discovery_enabled            = true
oidc_token_auth_enabled           = true
oidc_token_authentication_config = {
  issuer_url         = "https://token.actions.githubusercontent.com"
  ca_certificate     = null
  client_id          = "oke-kubernetes-cluster"
  signing_algorithms = "RS256"
  username_claim     = "sub"
  username_prefix    = "actions-oidc:"
  required_claims = [
    {
      key   = "repository"
      value = "GabrielFeodorov/k8stest"
    },
    {
      key   = "workflow"
      value = "oke-oidc"
    },
    {
      key   = "ref"
      value = "refs/heads/main"
    }

  ]
}


# Worker pool defaults
worker_pool_size = 1
worker_pool_mode = "node-pool"

# Worker defaults
await_node_readiness = "none"

worker_pools = {
  np1 = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 2,
    memory             = 24,
    size               = 1,
    boot_volume_size   = 50,
    kubernetes_version = "v1.32.1"
  }
  np2 = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 2,
    memory             = 24,
    size               = 3,
    boot_volume_size   = 150,
    kubernetes_version = "v1.32.1"
  }
}

# Security
allow_node_port_access       = false
allow_worker_internet_access = true
allow_worker_ssh_access      = true
control_plane_allowed_cidrs  = ["0.0.0.0/0"]

load_balancers          = "both"
preferred_load_balancer = "public"
