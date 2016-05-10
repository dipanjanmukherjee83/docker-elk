#!/bin/sh

function docker-clean() {
  forceWord=force

  if [ "${#}" -eq 2 ] && [ "${2}" != "${forceWord}" ]; then
    echo Usage: dclean [name prefix] [?force]
    return
  fi

  if [ "${1}" == "${forceWord}" ] || [ "${2}" == "${forceWord}" ]; then
    exclude_containers=""
  else
    exclude_containers=`docker ps -a -q -f label=keep=true 2>/dev/null`
  fi

  if [ ! -z "${1}" ] && [ "${1}" != "${forceWord}" ]; then
    end_containers=`docker ps -a -q -f name=${1} 2>/dev/null`
  else
    end_containers=`docker ps -a -q -f status=exited -f status=created 2>/dev/null`
  fi

  if [ ! -z "${exclude_containers}" ]; then
    end_containers=`echo ${end_containers} | tr " " "\n" | grep -v "${exclude_containers}"`
  fi
  docker rm -f ${end_containers} 2>/dev/null
  docker rmi `docker images --filter dangling=true -q 2>/dev/null` 2>/dev/null
}

docker-clean logspout* force
export LOGSTASH_IP=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' --type=container elk_logstash_1`
docker-compose -p logspout -f docker-compose-swarm-logspout.yml up -d
docker-compose -p logspout -f docker-compose-swarm-logspout.yml scale logspout=`docker info 2>/dev/null | grep ^Nodes: | awk '{print $2}'`
