FROM iide/java8-ubuntu
MAINTAINER Jon Herrmann <herrmann@interactive-instruments.de>

EXPOSE 8081

# Create artifactory user
RUN groupadd artifactory
RUN useradd -s /sbin/nologin -g artifactory -d /opt/artifactory artifactory
ENV ARTIFACTORY_HOME /opt/artifactory

ENV ARTIFACTORY_VERSION 4.7.4
RUN wget --quiet --no-cookies http://dl.bintray.com/content/jfrog/artifactory/jfrog-artifactory-oss-${ARTIFACTORY_VERSION}.zip -O /tmp/artifactory.zip

RUN unzip /tmp/artifactory.zip -d /opt/
RUN mv /opt/artifactory-oss-${ARTIFACTORY_VERSION} ${ARTIFACTORY_HOME}

RUN rm /tmp/artifactory.zip
RUN sed -i -e 's/Xmx1g/Xmx512m/g' /opt/artifactory/bin/artifactory.default


RUN chown -R artifactory:artifactory /opt/artifactory
RUN chmod 775 -R /opt/artifactory

# Volume path
VOLUME  ["/opt/artifactory/data /opt/artifactory/backup /opt/artifactory/etc/security/artifactory.key"]

ADD https://raw.githubusercontent.com/interactive-instruments/docker-images/master/artifactory-server/res/init.sh /init.sh
RUN chmod 555 /init.sh

WORKDIR /opt/artifactory
CMD ["/init.sh"]
