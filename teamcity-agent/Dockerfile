FROM de.ii/java8-ubuntu
MAINTAINER Jon Herrmann <herrmann@interactive-instruments.de>

EXPOSE 9090

# docker run -e TEAMCITY_SERVER=http://buildserver:48111 -dt -p 9090:9090 de.ii/teamcity-agent

# Install compiler
RUN add-apt-repository ppa:openjdk-r/ppa && apt-get update \
 && apt-get install -q -y --no-install-recommends \
 openjdk-8-jdk \
 git \
 && rm -rf /var/lib/apt/lists/*

# Create teamcity user
RUN groupadd -g 33301 teamcity
RUN useradd -u 33301 -s /sbin/nologin -g teamcity -m -d /home/teamcity teamcity

ADD res/setup_agent.sh /home/teamcity/setup_agent.sh
RUN chmod 555 -R /home/teamcity/setup_agent.sh

RUN mkdir -p /home/teamcity/.gradle/wrapper/dists
ADD res/init.gradle /home/teamcity/.gradle/init.gradle
RUN chmod 550 /home/teamcity/.gradle/init.gradle
RUN chown teamcity -R /home/teamcity/.gradle

RUN chmod 1777 /tmp

WORKDIR /home/teamcity/
ENV TEAMCITY_SERVER=http://teamcity
CMD ["/home/teamcity/setup_agent.sh"]
