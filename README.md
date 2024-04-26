# Create Connection

# Setup Postgres For Datastream
## Set up logical replication with pglogical
To set up logical replication with pglogical, logical decoding must be enabled on primary instance. Set `cloudsql.logical_decoding=on` on the cloud SQL instances, or `wal_level=logical` on an external instance. Additionally, pglogical must be enabled on both the primary and replica instance; set cloudsql.enable_pglogical=on on a Cloud SQL instance, or add pglogical to shared_preload_libraries on an external instance.

Refs: 
- https://cloud.google.com/sql/docs/postgres/replication/configure-logical-replication#set-up-logical-replication-with-pglogical

## Publication & Replication
Postgres require setting up Publication and Replication Slot to enable datastream replication

To create replication users need to have `replication` role.
```
ALTER USER USER_NAME WITH REPLICATION;
```

Create publication for specific table
```
CREATE PUBLICATION PUBLICATION_NAME
FOR TABLE SCHEMA1.TABLE1, SCHEMA2.TABLE2;
```

Create publication for specific schema
```
CREATE PUBLICATION PUBLICATION_NAME
FOR TABLES IN SCHEMA1, SCHEMA2;
```

Create publication for all tables
```
CREATE PUBLICATION PUBLICATION_NAME
FOR ALL TABLES;
```

Create Replication Slot, notes: each slot must have unique name accross all databases
```
SELECT PG_CREATE_LOGICAL_REPLICATION_SLOT('REPLICATION_SLOT_NAME', 'pgoutput');
```

Refs : 
- https://cloud.google.com/datastream/docs/configure-cloudsql-psql


