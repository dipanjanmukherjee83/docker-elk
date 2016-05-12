FROM kibana
MAINTAINER Vincent Boutour <vincent.boutour@gmail.com>

ENV KIBANA_CONFIG /opt/kibana/config/kibana.yml

RUN sed --in-place "s|^#\s*elasticsearch.username.*|elasticsearch.username: 'kibana4-server'|gi" ${KIBANA_CONFIG} \
 && sed --in-place "s|^#\s*elasticsearch.password.*|elasticsearch.password: 'P4SSW0RD'|gi" ${KIBANA_CONFIG} \
# && echo shield.encryptionKey: 'James Bond 007' >> ${KIBANA_CONFIG} \
# && kibana plugin --install kibana/shield/2.3.2 \
 && chown -R kibana:kibana /opt/kibana
