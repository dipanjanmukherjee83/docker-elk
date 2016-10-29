# docker-elk

[![Build Status](https://travis-ci.org/ViBiOh/docker-elk.svg?branch=master)](https://travis-ci.org/ViBiOh/docker-elk) 

* [![](https://imagelayers.io/badge/vibioh/elasticsearch:latest.svg)](https://imagelayers.io/?images=vibioh/elasticsearch:latest 'Get your own badge on imagelayers.io') ElasticSearch 
* [![](https://imagelayers.io/badge/vibioh/logspout:latest.svg)](https://imagelayers.io/?images=vibioh/logspout:latest 'Get your own badge on imagelayers.io') Logspout 

## Starting ElasticSearch - Logstash - Kibana

```
export DOMAIN=vibioh.fr
export ELASTIC_DIR=`realpath ./elastic_data`
sudo sysctl -w vm.max_map_count=262144

docker-compose -p elk up -d
export LOGSTASH_IP=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' --type=container elk_logstash_1`
docker-compose -p logspout -f docker-compose-logspout.yml up -d
```

Kibana will be accessible to http://kibana.your_domain_name if you use the awesome [Traefik](https://traefik.io). If not, you'll need to tweak the compose for changing `ports`.

Elasticsearch can be managed with [ElasticHQ](http://www.elastichq.org) on http://elasticsearch.your_domain_name/_plugin/hq

Logspout is used to forward all logs from the Docker daemon to Logstash. It connects to `/var/run/docker.sock` to read information from the daemon.

## Running inside a Docker Swarm

```
docker-compose -p elk -f docker-compose.yml -f docker-compose.swarm.yml up -d
```

You need to start Logspout on each Docker daemon, so on each node. We have a script for that. It assumes that `docker` command is connected to Docker Swarm and every node of Swarm is in the same Docker network (does I say Overlay ?!). We asume that Logstash container is named `elk_logstash_1` (need to be improved I know).

```
./start_logspout.sh
```
