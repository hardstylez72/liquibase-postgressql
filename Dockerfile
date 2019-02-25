FROM openjdk:8-jdk-alpine

RUN apk add --no-cache bash curl ca-certificates
RUN mkdir -p /opt/liquibase

ARG postgresql_driver_version=42.2.5

COPY ./src/postgresql-${postgresql_driver_version}.jar /opt/liquibase/
RUN chmod +x /opt/liquibase/postgresql-${postgresql_driver_version}.jar

ARG liquibase_version=3.5.3

ENV TARFILE_PATH=./src/liquibase-${liquibase_version}-bin.tar.gz \
    TARFILE_NAME=liquibase-${liquibase_version}-bin.tar.gz

COPY ${TARFILE_PATH} /opt/liquibase/${TARFILE_NAME}
RUN cd /opt/liquibase;\
    tar -xzf ${TARFILE_NAME};\
    rm ${TARFILE_NAME};\
    chmod +x liquibase;\
    ln -s /opt/liquibase/liquibase /usr/local/bin/liquibase;\
    mkdir /opt/jdbc

COPY ./src/run.sh /opt/liquibase/
RUN chmod +x /opt/liquibase/run.sh

RUN liquibase --version

WORKDIR /workspace

CMD ["/opt/liquibase/run.sh"]