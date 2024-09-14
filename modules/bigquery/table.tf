resource "google_bigquery_table" "table_with_uppercase_field" {
  count = 1
  dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  deletion_protection = false
  table_id   = "table_with_uppercase_field"
  expiration_time = "0"
  project    = var.project_id

  schema = <<EOL
  [
    {
      "name": "time",
      "type": "TIMESTAMP",
      "mode": "NULLABLE"
    }
  ]
  EOL
}
