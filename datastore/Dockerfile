FROM busybox
MAINTAINER J Herrmann <herrmann@interactive-instruments.de>

# A Docker container which realizes the volume pattern.
#
# Usage:
# Build the image with
# $ docker build -t datastore_img
# $ docker run -i -t -name datastore datastore_img
# Use the datastore container from another container
# $ docker run -d -volumes-from datastore another_container

RUN mkdir /data
RUN chmod 755 /data

VOLUME /data
CMD /bin/sh
