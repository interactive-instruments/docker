FROM postgres:9.3
MAINTAINER Jon Herrmann <herrmann@interactive-instruments.de>

ENV SHARED_BUFFERS 512MB

ADD https://raw.githubusercontent.com/interactive-instruments/docker-images/master/postgresql-server/res/init.sh /docker-entrypoint-initdb.d/
