FROM de.ii/java8-ubuntu
MAINTAINER Jon Herrmann <herrmann@interactive-instruments.de>

EXPOSE 8111

ENV TEAMCITY_DATA_PATH /data/teamcity


ENV TEAMCITY_PACKAGE TeamCity-9.1.6.tar.gz
ENV TEAMCITY_DOWNLOAD http://download.jetbrains.com/teamcity/

ENV JDBC_PACKAGE postgresql-9.4-1206-jdbc41.jar
ENV JDBC_DOWNLOAD http://jdbc.postgresql.org/download/
ENV JDBC_DEST /opt/JDBC

ENV DB_SERVER db
ENV DB_PWD pwd
ENV DB_USER user
ENV DB_SCHEMA schema

ENV ROOT_URL ci

# Create ci user
RUN groupadd ci
RUN useradd -s /sbin/nologin -g ci -d /opt/TeamCity/bin/ ci

# Download Teamcity
RUN wget --quiet --no-cookies  ${TEAMCITY_DOWNLOAD}${TEAMCITY_PACKAGE} -O /tmp/teamcity.tar.gz

# Unpack
RUN tar xzf /tmp/teamcity.tar.gz -C /opt
RUN rm /tmp/teamcity.tar.gz

# Download JDBC driver to /opt/Teamcity directory
RUN mkdir -p ${JDBC_DEST}
RUN wget --quiet --no-cookies ${JDBC_DOWNLOAD}${JDBC_PACKAGE} -O ${JDBC_DEST}/${JDBC_PACKAGE}

ADD res/init.sh /init.sh
RUN chmod 555 /init.sh
RUN mkdir -p ${TEAMCITY_DATA_PATH}/config/

RUN chown -R ci:ci /opt/TeamCity/ && chmod 755 -R /opt/TeamCity/
RUN chown -R ci:ci ${TEAMCITY_DATA_PATH} && chmod 755 -R ${TEAMCITY_DATA_PATH}

# Volume path
# VOLUME  ["/data/teamcity"]

# Initialization commands
####################################################
# USER ci
WORKDIR /opt/TeamCity/bin/
CMD ["/init.sh"]
