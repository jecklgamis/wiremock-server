# wiremock-server

[![Build](https://github.com/jecklgamis/wiremock-server/actions/workflows/build.yml/badge.svg)](https://github.com/jecklgamis/wiremock-server/actions/workflows/build.yml)

This is a Dockerized standalone [WireMock](http://wiremock.org/) server. You can use it to serve canned API responses in
your
functional or perf testing.

Docker: `docker run -p 8080:8080 jecklgamis/wiremock-server:main`

## Building
```bash
make all
```

## Running

```bash
make up
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

## Adding Stubs

- Add mapping files in `mappings` directory
- Add response files in `__files` directory
- Rebuild and run (`make up`)

## Related Resources

Gatling load generators:
* [gatling-java-example](https://github.com/jecklgamis/gatling-java-example)
* [gatling-kotlin-example](https://github.com/jecklgamis/gatling-kotlin-example)
* [gatling-scala-example](https://github.com/jecklgamis/gatling-scala-example)

