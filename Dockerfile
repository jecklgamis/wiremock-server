FROM envoyproxy/envoy-alpine:v1.19.1

RUN apk update && apk add --no-cache bash curl dumb-init  python3 py3-pip openjdk8-jre
COPY requirements.txt /
RUN pip install --upgrade pip &&  pip install -r /requirements.txt

COPY supervisor.ini /etc/supervisor.d/
RUN mkdir -p /var/log/supervisor

# supervisor
ENV WIREMOCK_VERSION 2.30.1
ENV WIREMOCK_HOME /wiremock

# wiremock
RUN mkdir -p ${WIREMOCK_HOME}
RUN cd ${WIREMOCK_HOME} && \
    curl -H 'Cache-Control: no-cache' -fsLO  https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-jre8-standalone/${WIREMOCK_VERSION}/wiremock-jre8-standalone-${WIREMOCK_VERSION}.jar

RUN mkdir -p ${WIREMOCK_HOME}/__files
RUN mkdir -p ${WIREMOCK_HOME}/mappings
COPY __files/ ${WIREMOCK_HOME}/__files/
COPY mappings/ ${WIREMOCK_HOME}/mappings/
COPY run-wiremock.sh /
RUN chmod +x /run-wiremock.sh

# envoy
COPY run-envoy.sh /
RUN chmod +x /run-envoy.sh
COPY envoy* /etc/envoy/
COPY server.crt /etc/
COPY server.key /etc/

EXPOSE 8080
EXPOSE 8443

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisor.d/supervisor.ini"]
