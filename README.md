# docker-elk

[![Build Status](https://travis-ci.org/ViBiOh/docker-elk.svg?branch=master)](https://travis-ci.org/ViBiOh/docker-elk) [![](https://imagelayers.io/badge/vibioh/logspout:latest.svg)](https://imagelayers.io/?images=vibioh/logspout:latest 'Get your own badge on imagelayers.io')

## Starting ElasticSearch - Logstash - Kibana

```
export DOMAIN=your_domain_name
docker-compose up -d
```

Kibana will be accessible to http://kibana.your_domain_name if you use the awesome [Traefik](https://traefik.io). If not, you'll need to tweak the compose for changing `ports`.

Logspout is used to forward all logs from the Docker daemon to Logstash. It connects to `/var/run/docker.sock` to read information from the daemon.


## Running inside a Docker Swarm

```
docker-compose -f docker-compose-swarm.yml up -d
```

You need to start Logspout on each Docker daemon, so on each node. We have a script for that. It assumes that `docker` command is connected to Docker Swarm and every node of Swarm is in the same Docker network (does I say Overlay ?!)

```
./start_logspout.sh
```
