
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.0"

  project_id      = local.host_project_id
  network_name    = local.vpc_name
  routing_mode    = "GLOBAL"
  shared_vpc_host = true

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = local.region
      subnet_private_access = "true"
      description           = "This subnet contains GKE cluster for paid"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "This subnet has a description"
    },
    {
      subnet_name               = "subnet-03"
      subnet_ip                 = "10.10.30.0/24"
      subnet_region             = "us-west1"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "pod-ip-range"
        ip_cidr_range = "10.0.0.0/14"
      },
      {
        range_name    = "services-ip-range"
        ip_cidr_range = "10.4.0.0/19"
      }
    ]

    subnet-02 = []
  }

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]

  depends_on = [google_project_iam_binding.container-engine]
}