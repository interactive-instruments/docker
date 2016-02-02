FROM de.ii/java7-ubuntu
MAINTAINER J Herrmann <herrmann@interactive-instruments.de>

EXPOSE 1984

# Use version for installation
ENV BASEX_VERSION 7.9

# Install BaseX
####################################################
# Download and install to opt
RUN wget --quiet --no-cookies http://files.basex.org/releases/${BASEX_VERSION}/BaseX79.zip -O /tmp/basex.zip
RUN unzip /tmp/basex.zip -d /opt/
RUN rm /tmp/basex.zip

# Add configuration file with changed JVM memory parameters
ADD res/basex/bin/basexserver /opt/basex/bin/basexserver

# Download functx extension
RUN wget --quiet --no-cookies http://files.basex.org/modules/expath/functx-1.0.xar -O /tmp/functx.xar

# Create basex user
RUN groupadd basex
RUN useradd -s /sbin/nologin -g basex -d /opt/basex basex
RUN chown -R basex:basex /opt/basex
RUN chmod 775 -R /opt/basex

# Install functx
RUN /opt/basex/bin/basex -c"REPO INSTALL /tmp/functx.xar"
RUN rm /tmp/functx.xar

####################################################

# JVM Parameters
####################################################
ENV JVM_OPT_MINM -Xms768m
ENV JVM_OPT_MAXM -Xmx3G
ENV JVM_OPT_MAXPS -XX:MaxPermSize=512m

USER basex
WORKDIR /opt/basex/bin/
CMD ["/opt/basex/bin/basexserver"]
