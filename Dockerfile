FROM kilna/liquibase
LABEL maintainer="Kilna kilna@kilna.com"

ARG jdbc_driver_version
ENV jdbc_driver_version=${jdbc_driver_version:-42.2.8}\
    jdbc_driver_download_url=https://jdbc.postgresql.org/download\
    LIQUIBASE_PORT=${LIQUIBASE_PORT:-5432}\
    LIQUIBASE_CLASSPATH=${LIQUIBASE_CLASSPATH:-/opt/jdbc/postgres-jdbc.jar}\
    LIQUIBASE_DRIVER=${LIQUIBASE_DRIVER:-org.postgresql.Driver}\
    LIQUIBASE_URL=${LIQUIBASE_URL:-'jdbc:postgresql://${HOST}:${PORT}/${DATABASE}'}

COPY test/ /opt/test_liquibase_postgres/
RUN set -x -e -o pipefail;\
    echo "JDBC DRIVER VERSION: $jdbc_driver_version";\
    chmod +x /opt/test_liquibase_postgres/run_test.sh;\
    cd /opt/jdbc;\
    jarfile=postgresql-${jdbc_driver_version}.jar;\
    curl -SOLs ${jdbc_driver_download_url}/${jarfile};\
    ln -s ${jarfile} postgres-jdbc.jar

