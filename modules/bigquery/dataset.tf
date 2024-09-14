resource "google_bigquery_dataset" "my_dataset" {
  dataset_id = "my_dataset"
  project    = var.project_id
}
