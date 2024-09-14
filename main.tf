provider "google" {
  project     = var.project_id
  region      = "us-central1"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.0.0"
    }
  }
}

module "bigquery" {
  source = "./modules/bigquery"
  project_id = var.project_id
}

import {
  to = module.bigquery.google_bigquery_table.table_with_uppercase_field[0]
  id = "projects/avid-influence-381703/datasets/my_dataset/tables/table_with_uppercase_field"
}


