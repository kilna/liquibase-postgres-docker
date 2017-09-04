# test

This directory describes how to test the JDBC driver works with liquibase within the container.

At build-time this directory is moved to /opt/liquibase_test, and the [run_test.sh](./run_test.sh) script is executed automatically through docker-compose.test.yml to test the build is working.
