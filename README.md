# docker-elk

[![Build Status](https://travis-ci.org/ViBiOh/docker-elk.svg?branch=master)](https://travis-ci.org/ViBiOh/docker-elk)

## Starting ElasticSearch - Logstash - Kibana

```
export ELASTIC_DIR=`realpath ./elastic_data`
export KIBANA_PASSWORD=`bcrypt password`
sudo sysctl -w vm.max_map_count=262144

docker-compose -p elk up -d
```

Logspout is used to forward all logs from the Docker daemon to Logstash. It connects to `/var/run/docker.sock` to read information from the daemon.
