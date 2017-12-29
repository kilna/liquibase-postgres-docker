#!/bin/bash
set -e -o pipefail

until nc -z -v -w 10 db 5432; do
  echo "Waiting for database connection..."
  sleep 3
done

echo "Applying changelog"
liquibase --changeLogFile=/opt/test_liquibase_postgres/changelog.xml updateTestingRollback

