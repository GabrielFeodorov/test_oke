provider "oci" {
  region = var.region
  auth   = "InstancePrincipal"
}

provider "oci" {
  alias  = "home"
  region = var.region
  auth   = "InstancePrincipal"
}


# terraform {
#   required_version = ">=1.12.0"
#   required_providers {
#     oci = {
#       source                = "oracle/oci"
#       version               = "7.4.0"
#       configuration_aliases = [oci.home]
#     }
#   }
#   backend "oci" {
#     bucket    = "tfstate2"
#     namespace = "idjuatm1d4mr"   #Update Object storage namespace
#     region    = "eu-frankfurt-1" #Update youre region
#     auth      = "InstancePrincipal"
#   }
# }
