# PostgreSQL

FROM ubuntu:trusty
MAINTAINER David Zumbrunnen <zumbrunnen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get install -y python-software-properties software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

USER postgres
RUN  /etc/init.d/postgresql start && \
      psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" && \
      createdb -O docker docker

VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
EXPOSE 5432

CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
