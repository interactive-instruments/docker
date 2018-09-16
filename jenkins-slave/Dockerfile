FROM iide/java8-ubuntu
MAINTAINER Jon Herrmann <herrmann@interactive-instruments.de>
# ORIGINAL SOURCE https://github.com/eea/eea.docker.jenkins.slave

ENV SWARM_MD5_SUM=823afa2f38ebc77bed4665676f88b08d \
SWARM_VERSION=3.14 \
JAVA_OPTS="-Xmx2048m"

RUN mkdir -p /var/jenkins_home/worker \
&& add-apt-repository ppa:git-core/ppa \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
git \
curl \
apt-transport-https \
ca-certificates \
maven \
openssh-client \
&& rm -rf /var/lib/apt/lists/* \
&& useradd -d /var/jenkins_home/worker -u 1000 -m -s /bin/bash jenkins \
&& wget --quiet --no-cookies https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$SWARM_VERSION/swarm-client-$SWARM_VERSION.jar -O /bin/swarm-client.jar \
&& echo "$SWARM_MD5_SUM  /bin/swarm-client.jar" | md5sum -c -

ADD https://raw.githubusercontent.com/interactive-instruments/docker-images/master/jenkins-slave/res/entrypoint.sh /docker-entrypoint.sh
WORKDIR /var/jenkins_home/worker
RUN chmod 555 /docker-entrypoint.sh && \
chown -v jenkins:jenkins /var/jenkins_home/worker/

USER jenkins
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java"]