# wiremock-server

[![Build](https://github.com/jecklgamis/wiremock-server/actions/workflows/build.yml/badge.svg)](https://github.com/jecklgamis/wiremock-server/actions/workflows/build.yml)

This is a Dockerized standalone [WireMock](http://wiremock.org/) server. This is reference implementation on how can use
it to serve canned API responses in your functional or perf testing tasks.

## Requirements

* Java 21
* Docker
* GNU Make

## Quick Start

To test drive, you can run the pre-built Docker container from Docker Hub:

```bash
docker run -p 8080:8080 jecklgamis/wiremock-server:main
````

and point your browser to http://localhost:8080.

## Building

```bash
docker build -t wiremock-server:main .
```

## Running

```bash
docker run -it wiremock-server:main
```

## Adding Stubs

- Add mapping files in `mappings` directory
- Add response files in `__files` directory
- Rebuild and run (`make up`)

Example request mapping:

`mappings/get-root.json`:

```json
{
  "request": {
    "method": "GET",
    "url": "/"
  },
  "response": {
    "status": 200,
    "bodyFileName": "root.json"
  }
}
```

`__files/root.json`:

```json
{
  "name": "wiremock-server",
  "message": "Relax, mock it!"
}
```

## Testing

Run a simple `curl` test:

```bash
% curl http://localhost:8080
{
  "name": "wiremock-server",
  "message": "Relax, mock it!"
}%
```

Run some Gatling perf tests:

```bash
TARGET_HOST=$(ipconfig getifaddr en0)
docker run -e "JAVA_OPTS=-DbaseUrl=http://$TARGET_HOST:8080/ -DdurationMin=1 -DrequestPerSecond=10" \
  -e SIMULATION_NAME=gatling.test.example.simulation.ExampleSimulation jecklgamis/gatling-java-example:main
```

## Tuning

If you are using Wiremock to serve a relatively large number of services, you will have to design it to scale.

- Start multiple instances behind a load balancer (i.e. Kubernetes or AWS ECS)
- Tune the CPU (Container runtime specific)
- Tune the Java heap size (-XmX)
- Tune the web container (Jetty)
    - container-threads (concurrent number of requests = response time * traffic as general guide)
    - jetty-acceptor-threads (typically set to the number of processors)
- Tune the Wiremock itself
    - Turn off request journal (`--no-request-journal`)
    - Enable async response  (`--async-response-enabled=true`)
    - Set number of async response threads (`--async-response-threads=10`)

See the [command line options in](https://wiremock.org/docs/standalone/java-jar/) for details or engage
the Wiremock community. You will have to run some form of load tests if you want to validate your perf assumptions or
simply observe Wiremock metrics and tune as needed.

See some Gatling resources below for some load generators.

## Related Resources

Gatling load generators:

* [gatling-java-example](https://github.com/jecklgamis/gatling-java-example)
* [gatling-kotlin-example](https://github.com/jecklgamis/gatling-kotlin-example)
* [gatling-scala-example](https://github.com/jecklgamis/gatling-scala-example)

