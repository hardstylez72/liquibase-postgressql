#!/usr/bin/env sh

set -e

liquibase --version

LOG_LEVEL=${LOG_LEVEL:-info}

echo ${LOG_LEVEL}
echo connecting to "'jdbc:postgresql://${PG_HOST}:${PG_PORT}/${PG_DATABASE}'"
liquibase \
  --driver=org.postgresql.Driver \
  --classpath=/opt/liquibase/postgresql-42.2.5.jar \
  --changeLogFile=/workspace/changelog.yml \
  --url="jdbc:postgresql://${PG_HOST}:${PG_PORT}/${PG_DATABASE}" \
  --username=${PG_USER} \
  --password=${PG_PASSWORD} \
  --logLevel=${LOG_LEVEL} \
  update
