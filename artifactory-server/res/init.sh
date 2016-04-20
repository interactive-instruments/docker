#!/bin/bash

chown -R artifactory:artifactory /opt/artifactory

webapp_name=${RELATIVE_URL}

cat >/opt/artifactory/tomcat/conf/Catalina/localhost/$webapp_name.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Context path="/$webapp_name" docBase="/opt/artifactory/webapps/$webapp_name.war" processTlds="false">
    <Manager pathname="" />
    <Valve className="org.apache.catalina.valves.RemoteIpValve" protocolHeader="x-forwarded-proto"/>
</Context>
EOF

sudo -u artifactory /opt/artifactory/bin/artifactory.sh
