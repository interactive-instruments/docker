FROM iide/java8-ubuntu
MAINTAINER Jon Herrmann <herrmann@interactive-instruments.de>

EXPOSE 9090

# Gradle version
ENV GRADLE_VERSION=2.10

# docker run -e TEAMCITY_SERVER=http://buildserver:48111 -dt -p 9090:9090 de.ii/teamcity-agent

# Install compiler
RUN add-apt-repository ppa:openjdk-r/ppa && apt-get update \
 && apt-get install -q -y --no-install-recommends \
 openjdk-8-jdk \
 git \
 maven \
 npm \
 && rm -rf /var/lib/apt/lists/*

# Install gradle
RUN wget http://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip
RUN unzip -oq ./gradle-${GRADLE_VERSION}-all.zip -d /opt/gradle
RUN ln -sfnv gradle-${GRADLE_VERSION} /opt/gradle/latest
ENV GRADLE_HOME=/opt/gradle/latest
ENV PATH=$PATH:$GRADLE_HOME/bin

# Create teamcity user
RUN groupadd -g 33301 teamcity
RUN useradd -u 33301 -s /sbin/nologin -g teamcity -m -d /home/teamcity teamcity

ADD https://raw.githubusercontent.com/interactive-instruments/docker-images/master/teamcity-agent/res/setup_agent.sh /home/teamcity/setup_agent.sh
RUN chmod 555 -R /home/teamcity/setup_agent.sh

RUN mkdir -p /home/teamcity/.gradle/wrapper/dists
RUN chown teamcity -R /home/teamcity/.gradle

RUN chmod 1777 /tmp

WORKDIR /home/teamcity/
ENV TEAMCITY_SERVER=http://teamcity:8111
ENV TEAMCITY_AGENT_DELAYED_START=40
CMD ["/home/teamcity/setup_agent.sh"]
