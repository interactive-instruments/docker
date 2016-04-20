#!/bin/bash

chown -R artifactory:artifactory /opt/artifactory
chmod 750 -R /opt/artifactory/

if [ -n "${RELATIVE_URL}" ]; then
if [ ! -f /opt/artifactory/webapps/${RELATIVE_URL}.war ]; then
echo "Changing context for relative URL ${RELATIVE_URL}"

rm /opt/artifactory/tomcat/conf/Catalina/localhost/artifactory.xml

cat << EOF > "/opt/artifactory/tomcat/conf/Catalina/localhost/${RELATIVE_URL}.xml"
<?xml version="1.0" encoding="UTF-8"?>
<Context path="/${RELATIVE_URL}" docBase="/opt/artifactory/webapps/${RELATIVE_URL}.war" processTlds="false">
    <Manager pathname="" />
    <Valve className="org.apache.catalina.valves.RemoteIpValve" protocolHeader="x-forwarded-proto"/>
</Context>
EOF
mv /opt/artifactory/webapps/artifactory.war /opt/artifactory/webapps/${RELATIVE_URL}.war
fi
fi

chown -R artifactory:artifactory /opt/artifactory
chmod 750 -R /opt/artifactory/

sudo -u artifactory sh -c "/opt/artifactory/bin/artifactory.sh"
