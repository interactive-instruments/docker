#!/usr/bin/env bash

AGENT_DIR="/home/teamcity/agent"

FIRST_INSTALL_SLEEP_TIME=120

if [ -z "$TEAMCITY_SERVER_URL" ]; then
    echo "Error: TEAMCITY_SERVER_URL is not set."
    echo
    exit
fi

echo "Agent directory set to ${AGENT_DIR}."

if [ ! -d "$AGENT_DIR" ]; then
    cd ${HOME}
    echo "Setting up Agent for the first time."
    echo "Sleeping ${FIRST_INSTALL_SLEEP_TIME} seconds to ensure server is up."
    sleep ${FIRST_INSTALL_SLEEP_TIME}
    while [ 1 ]; do
      wget --waitretry=30 --retry-connrefused --read-timeout=30 --timeout=15 -t 20 --continue $TEAMCITY_SERVER_URL/update/buildAgent.zip
      if [ $? = 0 ]; then break; fi;
      sleep 10;
    done;
    mkdir -p $AGENT_DIR
    unzip -q -d $AGENT_DIR buildAgent.zip
    rm buildAgent.zip
    chmod +x $AGENT_DIR/bin/agent.sh
    chown teamcity:teamcity -R $AGENT_DIR
    echo "serverUrl=${TEAMCITY_SERVER_URL}" > $AGENT_DIR/conf/buildAgent.properties
    ## Blank, created from build agent's host name
    echo "name=" >> $AGENT_DIR/conf/buildAgent.properties
    echo "workDir=${AGENT_DIR}/work" >> $AGENT_DIR/conf/buildAgent.properties
    echo "tempDir=${AGENT_DIR}/temp" >> $AGENT_DIR/conf/buildAgent.properties
    echo "systemDir=${AGENT_DIR}/system" >> $AGENT_DIR/conf/buildAgent.properties
    cat ${AGENT_DIR}/conf/buildAgent.properties
fi
sleep ${TEAMCITY_AGENT_DELAYED_START}
sudo -Hu teamcity sh -c 'export "${1}"; cd $AGENT_DIR/../ && ./agent/bin/agent.sh run' _ "AGENT_DIR=${AGENT_DIR}"
