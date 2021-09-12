
output "cluster_name" {
  value = module.gke.name
}

output "cluster_location" {
  value = module.gke.location
}

output "cluster_type" {
  value = module.gke.type
}
output "node_pool_zones" {
  value = module.gke.zones
}
output "node_pools_names" {
  value = module.gke.node_pools_names
}

output "node_pools_versions" {
  value = module.gke.node_pools_versions
}

output "node_pool_service_account" {
  value = module.gke.service_account
}

output "nat_router" {
  value = module.cloud_router.router
}
