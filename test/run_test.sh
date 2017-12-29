#!/bin/bash
set -e -o pipefail

export LANG=en_US.utf8
export PGDATA=/var/lib/postgresql/data

echo "Adding postgres package"
apk add --no-cache sudo postgresql postgresql-contrib

echo "Preparing postgres"
mkdir -p "${PGDATA}"
chown -R postgres "${PGDATA}"
sudo -u postgres initdb -D "${PGDATA}"
echo $'\nhost all all 127.0.0.1/0 md5' >> "${PGDATA}/pg_hba.conf"
sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" "$PGDATA/postgresql.conf"

echo "Creating database"
echo "CREATE DATABASE liquibase;" \
  | sudo -u postgres postgres --single -jE -D "${PGDATA}"

echo "Creating user"
echo "CREATE USER liquibase WITH SUPERUSER PASSWORD 'liquibase';" \
  | sudo -u postgres postgres --single -jE -D "${PGDATA}"

echo "Starting postgres"
sudo -u postgres pg_ctl -D "${PGDATA}" start

echo "Applying changelog"
liquibase --changeLogFile=/opt/test_liquibase_postgres/changelog.xml updateTestingRollback

echo "Stopping postgres"
sudo -u postgres pg_ctl -D "${PGDATA}" stop

