FROM elasticsearch:5-alpine

RUN echo 'http.cors.enabled: true' >> ./config/elasticsearch.yml \
 && echo 'http.cors.allow-origin: "*"' >> ./config/elasticsearch.yml \
 && echo 'http.cors.allow-methods: OPTIONS, HEAD, GET, POST, PUT, DELETE' >> ./config/elasticsearch.yml \
 && echo 'http.cors.allow-headers: X-Requested-With, X-Auth-Token, Content-Type, Content-Length' >> ./config/elasticsearch.yml
 && sed -i "s|^-Xms.*|-Xms512m|" ./config/jvm.options \
 && sed -i "s|^-Xmx.*|-Xmx512m|" ./config/jvm.options
