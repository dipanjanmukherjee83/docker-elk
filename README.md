# docker-elk

[![Build Status](https://travis-ci.org/ViBiOh/docker-elk.svg?branch=master)](https://travis-ci.org/ViBiOh/docker-elk) 

* [![](https://imagelayers.io/badge/vibioh/elasticsearch:latest.svg)](https://imagelayers.io/?images=vibioh/elasticsearch:latest 'Get your own badge on imagelayers.io') ElasticSearch 
* [![](https://imagelayers.io/badge/vibioh/logspout:latest.svg)](https://imagelayers.io/?images=vibioh/logspout:latest 'Get your own badge on imagelayers.io') Logspout 

## Starting ElasticSearch - Logstash - Kibana

```
export DOMAIN=your_domain_name
export NODE=docker
export NETDATA_DIR=`realpath ./`
docker-compose -p elk up -d
docker-compose -p logspout -f docker-compose-logspout.yml up -d
docker-compose -p netdata -f docker-compose-netdata.yml up -d
```

Kibana will be accessible to http://kibana.your_domain_name if you use the awesome [Traefik](https://traefik.io). If not, you'll need to tweak the compose for changing `ports`.

Shield is configured on each component of the stack to ensure authentication. Default user is admin/P4SSW0RD (need to be improve with environment variables).

Elasticsearch can be managed with [ElasticHQ](http://www.elastichq.org) on http://elasticsearch.your_domain_name/_plugin/hq

Logspout is used to forward all logs from the Docker daemon to Logstash. It connects to `/var/run/docker.sock` to read information from the daemon.

Netdata is used for monitoring.

## Running inside a Docker Swarm

```
docker-compose -p elk -f docker-compose.yml -f docker-compose.swarm.yml up -d
```

You need to start Logspout on each Docker daemon, so on each node. We have a script for that. It assumes that `docker` command is connected to Docker Swarm and every node of Swarm is in the same Docker network (does I say Overlay ?!). We asume that Logstash container is named `elk_logstash_1` (need to be improved I know).

```
./start_logspout.sh
export NODE=docker
docker-compose -p netdata -f docker-compose-netdata.yml -f docker-compose-netdata.swarm.yml up -d
export NODE=docker-node-1
docker-compose -p netdata -f docker-compose-netdata.yml -f docker-compose-netdata.swarm.yml scale netdata=2
```
