

resource "google_service_account" "k8s" {
  project    = local.service_project_id
  account_id = "tf-gke-paid-network"

  depends_on = [google_project.service_project]
}


resource "google_compute_shared_vpc_service_project" "service" {
  host_project    = local.host_project_id
  service_project = local.service_project_id

  depends_on = [module.vpc]
}

resource "google_compute_subnetwork_iam_binding" "binding" {
  project    = local.host_project_id
  region     = local.region
  subnetwork = module.vpc.subnets_names[0]

  role = "roles/compute.networkUser"
  members = [
    "serviceAccount:${google_project.service_project.number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${google_project.service_project.number}@container-engine-robot.iam.gserviceaccount.com"
  ]
}

resource "google_project_iam_binding" "container-engine" {
  project = local.host_project_id
  role    = "roles/container.hostServiceAgentUser"

  members = [
    "serviceAccount:service-${google_project.service_project.number}@container-engine-robot.iam.gserviceaccount.com",
  ]
  depends_on = [google_project_service.service]
}

