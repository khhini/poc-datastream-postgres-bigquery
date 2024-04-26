import {
  id = "projects/ebc-cloud-dev-02/locations/asia-southeast2/connectionProfiles/protelindo-ticket-db-qa-conn"
  to = google_datastream_connection_profile.source["protelindo_ticket_qa"]
}

import {
  id = "projects/ebc-cloud-dev-02/locations/asia-southeast2/connectionProfiles/protelindo-log-db-qa-conn"
  to = google_datastream_connection_profile.source["protelindo_log_qa"]
}


import {
  id = "projects/ebc-cloud-dev-02/locations/asia-southeast2/connectionProfiles/ebc-cloud-dev-02-bigquery-conn"
  to = google_datastream_connection_profile.destination
}

import {
  id = "projects/ebc-cloud-dev-02/locations/asia-southeast2/streams/protelindo-ticket-db-qa-bq-stream"
  to = google_datastream_stream.protelindo_db_bq_stream["protelindo_ticket_qa"]
}

import {
  id = "projects/ebc-cloud-dev-02/locations/asia-southeast2/streams/protelindo-log-db-qa-bq-stream"
  to = google_datastream_stream.protelindo_db_bq_stream["protelindo_log_qa"]
}