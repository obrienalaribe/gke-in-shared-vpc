resource "random_integer" "suffix" {
  max = 10000
  min = 100
}

locals {
  region               = "europe-west1"
  org_id               = "610859635209"
  vpc_name             = "mv-vpc"
  billing_account      = "0196EB-64B4C0-8441F7"
  host_project_name    = "mv-network-host"
  service_project_name = "mv-service-project"
  host_project_id      = "${local.host_project_name}-${random_integer.suffix.result}"
  service_project_id   = "${local.service_project_name}-${random_integer.suffix.result}"
  projects_api         = "container.googleapis.com"
  nat_router_name          = "${local.vpc_name}-${local.region}-router"
  secondary_ip_ranges = {
    "pod-ip-range"      = "10.0.0.0/14",
    "services-ip-range" = "10.4.0.0/19"
  }
}