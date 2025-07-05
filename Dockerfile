FROM ubuntu:24.04

RUN apt update -y && apt install -y openjdk-21-jre-headless curl && rm -rf /var/lib/apt/lists/*

ENV WIREMOCK_VERSION=3.13.1
ENV WIREMOCK_HOME=/wiremock

RUN mkdir -p $WIREMOCK_HOME
RUN cd $WIREMOCK_HOME && \
    curl -H 'Cache-Control: no-cache' -fsLO  https://repo1.maven.org/maven2/org/wiremock/wiremock-standalone/${WIREMOCK_VERSION}/wiremock-standalone-${WIREMOCK_VERSION}.jar
RUN mkdir -p $WIREMOCK_HOME/__files
RUN mkdir -p $WIREMOCK_HOME/mappings

COPY __files/ $WIREMOCK_HOME/__files/
COPY mappings/ $WIREMOCK_HOME/mappings/

EXPOSE 8080

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
