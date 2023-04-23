# wiremock-server

[![Build](https://github.com/jecklgamis/wiremock-server/actions/workflows/build.yml/badge.svg)](https://github.com/jecklgamis/wiremock-server/actions/workflows/build.yml)

This is a Dockerized standalone [WireMock](http://wiremock.org/) server.

Docker: `docker run -p 8080:8080 jecklgamis/wiremock-server:main`

## Building
```
make all
```

## Running
```bash
make up
```

## Adding Stubs
- Add mapping files in `mappings` directory
- Add response files in `__files` directory
- Rebuild and run (`make up`)

## Related Resources
* [gatling-test-example](https://github.com/jecklgamis/gatling-test-example) - for generating your perf test traffic
