#!/bin/bash -

export JAVA_HOME=/etc/alternatives/jre
export FUSEKI_HOME=/opt/apache-jena-fuseki-4.0.0
export FUSEKI_BASE=/opt/apache-jena-fuseki-4.0.0/run

export JVM_ARGS="-Xmx2400M"

/opt/apache-jena-fuseki-4.0.0/fuseki-server  --port=8080

