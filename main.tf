resource "google_datastream_connection_profile" "source" {
  for_each = var.datastreams
  connection_profile_id = "${replace(each.value.name, "_", "-")}-db-${each.value.env}-conn"
  display_name = "${replace(each.value.name, "_", "-")}-db-${each.value.env}-conn"
  location = var.region
  

  postgresql_profile {
    hostname = each.value.hostname
    database = each.value.name
    username = each.value.username
    password = each.value.password
    port = each.value.port
  }

  labels = {
    "env" = each.value.env
    "db" = each.value.name
    "source" = "cloud_sql"
  }
}

resource "google_datastream_connection_profile" "destination" {
  connection_profile_id = "${var.project_id}-bigquery-conn"
  display_name = "${var.project_id}-bigquery-conn"
  location = var.region

  labels = {
    "env" = "sit"
    "source" = "bigquery"
  }
  
  bigquery_profile {}
} 

resource "google_bigquery_dataset" "dataset" {
  for_each = var.datastreams
  dataset_id                  = "${replace(each.value.name, "-", "_")}_db_${each.value.env}_replica"
  description                 = "Database Replication for ${each.value.name}"
  location                    = var.region

  labels = {
    env = each.value.env
    db  = each.value.name
  }
}


resource "google_datastream_stream" "protelindo_db_bq_stream" {
  for_each = var.datastreams
  display_name  = "${replace(each.value.name, "_", "-")}-db-${each.value.env}-bq-stream"
  location      = var.region
  stream_id     = "${replace(each.value.name, "_", "-")}-db-${each.value.env}-bq-stream"
  desired_state = each.value.desired_state

  source_config {
    source_connection_profile = google_datastream_connection_profile.source[each.key].id
    postgresql_source_config {
      max_concurrent_backfill_tasks = 0
      publication = each.value.publication
      replication_slot = each.value.replication_slot
    }
  }

  destination_config {
    destination_connection_profile = google_datastream_connection_profile.destination.id
    bigquery_destination_config {
      data_freshness = "0s"
      single_target_dataset {
        dataset_id = google_bigquery_dataset.dataset[each.key].id
      }
    }
  }

  backfill_all {
  }

  labels = {
    "db"     = "${each.value.name}"
    "env"    = "${each.value.env}"
    "source" = "cloud_sql"
    "target" = "bigquery"
  }
}