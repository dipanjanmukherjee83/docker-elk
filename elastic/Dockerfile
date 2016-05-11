FROM elasticsearch
MAINTAINER Vincent Boutour <vincent.boutour@gmail.com>

RUN ./bin/plugin install royrusso/elasticsearch-HQ \
 && ./bin/plugin install license \
 && ./bin/plugin install shield \
 && ./bin/shield/esusers useradd admin -p "P4SSW0RD" -r admin  \
 && ./bin/shield/esusers useradd logstash -p "P4SSW0RD" -r logstash \
 && ./bin/shield/esusers useradd kibana4_server -p "P4SSW0RD" -r kibana4_server 
