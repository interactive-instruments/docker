#!/bin/bash

echo "Running custom init"


sed -i "s/^\(shared_buffers\s*=\s*\).*$/\1$SHARED_BUFFERS/g" /var/lib/postgresql/data/postgresql.conf

echo "checkpoint_segments=32" >> /var/lib/postgresql/data/postgresql.conf
echo "checkpoint_completion_target=0.9" >> /var/lib/postgresql/data/postgresql.conf

echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf

chown root:root /docker-entrypoint-initdb.d/*.sql
chmod 550 /docker-entrypoint-initdb.d/*.sql
ls -l /docker-entrypoint-initdb.d
