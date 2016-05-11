FROM kibana

ENV KIBANA_CONFIG /opt/kibana/config/kibana.yml

RUN kibana plugin --install kibana/shield/2.3.2 \
 && sed --in-place "s|^#elasticsearch.username.*|elasticsearch.username: \"kibana4-server\"|gi" ${KIBANA_CONFIG} \
 && sed --in-place "s|^#elasticsearch.password.*|elasticsearch.password: \"P4SSW0RD\"|gi" ${KIBANA_CONFIG} \
 && chown -R kibana:kibana /opt/kibana