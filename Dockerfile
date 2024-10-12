FROM ubuntu:22.04

RUN apt update -y && apt install -y openjdk-21-jre-headless python3 python3-pip curl dumb-init && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /
RUN pip install --upgrade pip &&  pip install -r /requirements.txt

COPY supervisor.ini /etc/supervisor.d/
RUN mkdir -p /var/log/supervisor

# supervisor
ENV WIREMOCK_VERSION 3.9.1
ENV WIREMOCK_HOME /wiremock

# wiremock
RUN mkdir -p ${WIREMOCK_HOME}
RUN cd ${WIREMOCK_HOME} && \
    curl -H 'Cache-Control: no-cache' -fsLO  https://repo1.maven.org/maven2/org/wiremock/wiremock-standalone/${WIREMOCK_VERSION}/wiremock-standalone-${WIREMOCK_VERSION}.jar
RUN mkdir -p ${WIREMOCK_HOME}/__files
RUN mkdir -p ${WIREMOCK_HOME}/mappings
COPY __files/ ${WIREMOCK_HOME}/__files/
COPY mappings/ ${WIREMOCK_HOME}/mappings/
COPY run-wiremock.sh /
RUN chmod +x /run-wiremock.sh

EXPOSE 8080

COPY docker-entrypoint.sh /
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/docker-entrypoint.sh"]
