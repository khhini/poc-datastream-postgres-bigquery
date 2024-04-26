variable "project_id" {
    type = string
}

variable "region" {
    type = string
}

variable "zone" {
    type = string
}

variable "datastreams" {
    type = map(object({
        name = string
        hostname = string
        env = string
        username = string
        password = string
        port = number
        publication = string
        replication_slot = string
        desired_state = string
    }))
    # Example
    # database_1 = {
    #   name = "database_1_name",
    #   hostname = "localhost"
    #   env = "env",
    #   username = "datbase_1_username",
    #   password = "database_1_password",
    #   port = 5432,
    #   publication = "database_1_publication"",
    #   replication_slot = "database_1_replication_slot"
    # },
    # database_2 = {
    #   name = "database_2_name",
    #   hostname = "localhost"
    #   env = "env"
    #   username = "dataase_2_username",
    #   password = "database_2_password",
    #   port = 5432,
    #   publication = "database_2_publication"",
    #   replication_slot = "database_2_replication_slot"
    # },
    # ...
}
