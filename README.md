# docker-elk

[![Build Status](https://travis-ci.org/ViBiOh/docker-elk.svg?branch=master)](https://travis-ci.org/ViBiOh/docker-elk)

## Starting ElasticSearch - Logstash - Kibana

```
read -p "KIBANA_PASSWORD=" KIBANA_RAW_PASSWORD

export ELASTIC_DIR=`realpath ./elastic_data`
export KIBANA_PASSWORD=`bcrypt ${KIBANA_RAW_PASSWORD}`
sudo sysctl -w vm.max_map_count=262144

docker-compose -p elk up -d
```

Logspout is used to forward all logs from the Docker daemon to Logstash. It connects to `/var/run/docker.sock` to read information from the daemon.


## Loggly

```
read -p "LOGGLY_API_KEY=" LOGGLY_API_KEY
export LOGGLY_API_KEY=${LOGGLY_API_KEY}

docker-compose -p log -f docker-compose.loggly.yml up -d
```