resource "google_compute_firewall" "nginx_lb" {
  name = "k8s-fw-a78e438b51e7443199cc8dd3b1fd8c38"
  project = local.host_project_id
  network = module.vpc.network_name
  description = "Nginx service FW rule"

   allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["gke-paid-network-cluster-3b01825e-node"]
}

resource "google_compute_firewall" "nginx_lb_health_check" {
  name = "k8s-695a10fb08cb08a1-node-http-hc"
  project = local.host_project_id
  network = module.vpc.network_name
  description = "Nginx service backend health check"

   allow {
    protocol = "tcp"
    ports    = ["10256"]
  }

  source_ranges = ["130.211.0.0/22" , "209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
  target_tags = ["gke-paid-network-cluster-3b01825e-node"]
}