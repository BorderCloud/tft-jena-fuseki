#!/bin/bash -

export JAVA_HOME=/etc/alternatives/jre
export FUSEKI_HOME=/opt/apache-jena-fuseki-3.4.0

/opt/apache-jena-fuseki-3.4.0/fuseki-server --config=/opt/apache-jena-fuseki-3.4.0/fuseki-config.ttl --port=80

