FROM elasticsearch
MAINTAINER Vincent Boutour <vincent.boutour@gmail.com>

RUN ./bin/plugin install royrusso/elasticsearch-HQ \
 && echo 'http.cors.enabled: true' >> ./config/elasticsearch.yml \
 && echo 'http.cors.allow-origin: "*"' >> ./config/elasticsearch.yml \
 && echo 'http.cors.allow-methods: OPTIONS, HEAD, GET, POST, PUT, DELETE' >> ./config/elasticsearch.yml \
 && echo 'http.cors.allow-headers: X-Requested-With, X-Auth-Token, Content-Type, Content-Length' >> ./config/elasticsearch.yml
