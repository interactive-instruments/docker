#!/bin/bash

echo "Running custom init"

if [ -n "${USERS}" ]; then
  
  users=($(awk -F',' '{for (i = 1 ; i <= NF ; i++) print $i}' <<< "${USERS}"));
  passwords=($(awk -F',' '{for (i = 1 ; i <= NF ; i++) print $i}' <<< "${PASSWORDS}"));
  schemas=($(awk -F',' '{for (i = 1 ; i <= NF ; i++) print $i}' <<< "${SCHEMAS}"));
  
  for i in ${!users[*]}; do
     echo "****** CREATING USER \"${users[i]}\" and database \"${schemas[i]}\" ******"


gosu postgres postgres --single <<- EOSQL
   CREATE DATABASE ${schemas[i]};
   CREATE USER ${users[i]};
   ALTER USER ${users[i]} with password '${passwords[i]}';
   ALTER USER ${users[i]} CREATEDB;
   GRANT ALL PRIVILEGES ON DATABASE ${schemas[i]} to ${users[i]};
EOSQL
     echo ""
     echo "******OK ******"
  done
fi

sed -i "s/^\(shared_buffers\s*=\s*\).*$/\1$SHARED_BUFFERS/g" /var/lib/postgresql/data/postgresql.conf

echo "checkpoint_segments=32" >> /var/lib/postgresql/data/postgresql.conf
echo "checkpoint_completion_target=0.9" >> /var/lib/postgresql/data/postgresql.conf

echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf