FROM kilna/liquibase

ARG postgres_jdbc_version=42.1.4
ARG postgres_jdbc_download_url=https://jdbc.postgresql.org/download

ENV LIQUIBASE_PORT=${LIQUIBASE_PORT:-5432}\
    LIQUIBASE_CLASSPATH=${LIQUIBASE_CLASSPATH:-/opt/jdbc/postgres-jdbc.jar}\
    LIQUIBASE_DRIVER=${LIQUIBASE_DRIVER:-org.postgresql.Driver}\
    LIQUIBASE_URL=${LIQUIBASE_URL:-'jdbc:postgresql://${HOST}:${PORT}/${DATABASE}'}

COPY test/ /opt/test/
RUN set -e -o pipefail;\
    chmod +x /opt/test/run_test.sh;\
    cd /opt/jdbc;\
    jarfile=postgresql-${postgres_jdbc_version}.jar;\
    curl -SOLs ${postgres_jdbc_download_url}/${jarfile};\
    ln -s ${jarfile} postgres-jdbc.jar;\
    set | grep -F LIQUIBASE_

