# PostgreSQL

FROM ubuntu:utopic
MAINTAINER David Zumbrunnen <zumbrunnen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y python-software-properties software-properties-common postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4

ADD postgresql.conf /etc/postgresql/9.4/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.4/main/pg_hba.conf

USER postgres
RUN  pg_dropcluster --stop 9.4 main && \
      pg_createcluster --start -e UTF-8 9.4 main && \
      psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" && \
      createdb -O docker docker

VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
EXPOSE 5432

CMD ["/usr/lib/postgresql/9.4/bin/postgres", "-D", "/var/lib/postgresql/9.4/main", "-c", "config_file=/etc/postgresql/9.4/main/postgresql.conf"]
