FROM iide/java8-ubuntu
MAINTAINER Jon Herrmann <herrmann@interactive-instruments.de>
# ORIGINAL SOURCE https://github.com/eea/eea.docker.jenkins.slave

ENV MD5_SUM 15c1f0937b9b8dd3ceca8f2418801b54

RUN mkdir -p /var/jenkins_home \
 && useradd -d /var/jenkins_home/worker -u 1000 -m -s /bin/bash jenkins \
 && curl -o /bin/swarm-client.jar -SL http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar \
 && echo "$MD5_SUM  /bin/swarm-client.jar" | md5sum -c -
 
COPY https://raw.githubusercontent.com/interactive-instruments/docker-images/master/jenkins-slave/res/entrypoint.sh /docker-entrypoint.sh
WORKDIR /var/jenkins_home/worker

USER jenkins
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-Xmx2048m", "-jar", "/bin/swarm-client.jar", "-fsroot", "/var/jenkins_home/worker/"]
