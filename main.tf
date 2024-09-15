provider "google" {
  project     = var.project_id
  region      = "us-central1"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.2.0"
    }
  }
}

resource "google_bigquery_dataset" "my_dataset" {
  dataset_id = "my_dataset"
  project    = var.project_id
}

resource "google_bigquery_table" "source_table" {
  dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  deletion_protection = false
  table_id   = "source_table"
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

/*
resource "google_bigquery_table" "test_table" {
  dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  deletion_protection = false
  table_id   = "test_table"
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

import {
  to = google_bigquery_table.test_table
  id = "projects/avid-influence-381703/datasets/my_dataset/tables/test_table"
}
*/
