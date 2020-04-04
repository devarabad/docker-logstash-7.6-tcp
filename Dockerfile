FROM docker.elastic.co/logstash/logstash:7.6.1
# RUN bin/logstash-plugin update
RUN bin/logstash-plugin install logstash-input-tcp