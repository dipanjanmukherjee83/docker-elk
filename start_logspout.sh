#!/bin/sh


export LOGSTASH_IP=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' --type=container elk_logstash_1`
docker-compose -p logspout -f docker-compose-swarm-logspout.yml up -d
docker-compose -p logspout -f docker-compose-swarm-logspout.yml scale logspout=`docker info 2>/dev/null | grep ^Nodes: | awk '{print $2}'`