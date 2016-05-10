FROM elasticsearch
MAINTAINER Vincent Boutour <vincent.boutour@gmail.com>

RUN ./bin/plugin install royrusso/elasticsearch-HQ \
 && ./bin/plugin install license \
 && ./bin/plugin install shield \
 && ./bin/shield/esusers useradd es_admin -r admin \
 && ./bin/shield/esusers useradd kibana4_server -r kibana4_server
