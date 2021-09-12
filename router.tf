module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 0.4"
  project = local.host_project_id
  name    = local.nat_router_name
  network = module.vpc.network_name
  region  = local.region

  nats = [{
    name = "${local.vpc_name}-${local.region}-nat-gateway"
  }]
}