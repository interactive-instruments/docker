#!/bin/bash

chown -R artifactory:artifactory /opt/artifactory

webapp_name=${RELATIVE_URL}

cat << EOF > "/opt/artifactory/tomcat/conf/Catalina/localhost/$webapp_name.xml"
<?xml version="1.0" encoding="UTF-8"?>
<Context path="/$webapp_name" docBase="/opt/artifactory/webapps/$webapp_name.war" processTlds="false">
    <Manager pathname="" />
    <Valve className="org.apache.catalina.valves.RemoteIpValve" protocolHeader="x-forwarded-proto"/>
</Context>
EOF

sudo -u artifactory sh -c "/opt/artifactory/bin/artifactory.sh"
