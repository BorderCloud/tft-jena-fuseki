#!/bin/bash -

export JAVA_HOME=/etc/alternatives/jre
export FUSEKI_HOME=/opt/apache-jena-fuseki-3.8.0
export FUSEKI_BASE=/opt/apache-jena-fuseki-3.8.0/run

export JVM_ARGS="-Xmx2400M"

/opt/apache-jena-fuseki-3.8.0/fuseki-server --config=/opt/apache-jena-fuseki-3.8.0/fuseki-config.ttl --port=8080

