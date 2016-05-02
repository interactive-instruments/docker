FROM iide/java8-ubuntu
MAINTAINER Jon Herrmann <herrmann@interactive-instruments.de>
# ORIGINAL SOURCE https://github.com/eea/eea.docker.jenkins.slave

ENV SWARM_MD5_SUM=15c1f0937b9b8dd3ceca8f2418801b54

RUN mkdir -p /var/jenkins_home \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
  git \
  curl \
  apt-transport-https \
  ca-certificates \
 && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
 && echo “deb https://apt.dockerproject.org/repo ubuntu-trusty main” > /etc/apt/sources.list.d/docker.list \
 && sudo apt-get update \
 && apt-get install -y --no-install-recommends docker-engine \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -d /var/jenkins_home/worker -u 1000 -m -s /bin/bash jenkins \
 && wget --quiet --no-cookies http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar -O /bin/swarm-client.jar \
 && echo "$SWARM_MD5_SUM  /bin/swarm-client.jar" | md5sum -c -

ADD https://raw.githubusercontent.com/interactive-instruments/docker-images/master/jenkins-slave/res/entrypoint.sh /docker-entrypoint.sh
RUN chmod 555 /docker-entrypoint.sh
WORKDIR /var/jenkins_home/worker

USER jenkins
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-Xmx2048m", "-jar", "/bin/swarm-client.jar", "-fsroot", "/var/jenkins_home/worker/"]
