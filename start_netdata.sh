#!/bin/bash

function swarm-node-name() {
  curl --insecure --cert ${DOCKER_CERT_PATH}/cert.pem --key ${DOCKER_CERT_PATH}/key.pem --silent -X GET https://${DOCKER_HOST}/info | pcregrep -o1 '(?:\["\s(\S*?)",".*?"\].*?)'
}

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
}

docker-clean netdata* force
export NETDATA_DIR=`realpath ./tv`

docker-compose -p netdata -f docker-compose-netdata.yml -f docker-compose-netdata.swarm.yml up -d tv
i=0
for swarm_node in `swarm-node-name`; do
  ((i++)) 
  
  export NODE=${swarm_node}
  if [ "${i}" -eq 1 ]; then
    docker-compose -p netdata -f docker-compose-netdata.yml -f docker-compose-netdata.swarm.yml up -d netdata
  else
    docker-compose -p netdata -f docker-compose-netdata.yml -f docker-compose-netdata.swarm.yml scale netdata=${i}
  fi
done
