resource "google_project" "network_host" {
  name                = local.host_project_name
  project_id          = local.host_project_id
  billing_account     = local.billing_account
  org_id              = local.org_id
  auto_create_network = false
}

resource "google_project" "service_project" {
  name                = local.service_project_name
  project_id          = local.service_project_id
  billing_account     = local.billing_account
  org_id              = local.org_id
  auto_create_network = false
}

resource "google_project_service" "host" {
  project = google_project.network_host.number
  service = local.projects_api
}

// TODO: move to seperate workspace
resource "google_project_service" "service" {
  project = google_project.service_project.number
  service = local.projects_api
}