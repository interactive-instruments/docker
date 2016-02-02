FROM de.ii/base-ubuntu
MAINTAINER J Herrmann <herrmann@interactive-instruments.de>

# Install JAVA 7 (and Tomcat native library)
####################################################
RUN apt-get update \
 && apt-get install -q -y --no-install-recommends \
 openjdk-7-jre-headless \
 libtcnative-1 \
 && rm -rf /var/lib/apt/lists/*