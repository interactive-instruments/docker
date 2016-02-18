FROM postgres:9.3
MAINTAINER Jon Herrmann <herrmann@interactive-instruments.de>

ENV SHARED_BUFFERS 512MB

ADD res/init.sh /docker-entrypoint-initdb.d/
