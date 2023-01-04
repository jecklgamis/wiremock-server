# wiremock-server-template

[![Build](https://github.com/jecklgamis/wiremock-server-template/actions/workflows/build.yml/badge.svg)](https://github.com/jecklgamis/wiremock-server-template/actions/workflows/build.yml)

This is a Dockerized standalone [WireMock](http://wiremock.org/) server for your API, functional, or perf testing needs.

Docker: `docker run -p 8080:8080 jecklgamis/wiremock-server-template:main`


## What's In The Box?

* [WireMock](http://wiremock.org/) standalone server - for serving stubbed API responses
* [Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/) - for SSL termination, observability, proxying, etc.
* [Supervisord](http://supervisord.org/) - for running processes in parallel
* [Docker](https://www.docker.com/) image - for self-contained runtime environment

Quick test:

Open a terminal and run:

```
$ docker run -it jecklgamis/wiremock-server-template:latest
```

In another terminal, run:

```
$ curl http://localhost:8080 
```

## Building

```
make all 
```

This generates self-signed SSL certs and Docker image.

## Running

```bash
make run 
```

You can also run `make up` which will build and run the image in one go.

## Testing A Stub

```bash
$ curl  http://localhost:8080
{
  "name": "wiremock-server-template",
  "message": "Relax, mock it!"
}     
```

The request mapping file (`mappings/root.json`):

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
````

The stubbed response (`__files/root.json`)

```json
{
  "name": "wiremock-server-template",
  "message": "Relax, mock it!"
}
```

## Adding Stubs

- Add mapping files in `mappings` dir
- Add response files in `__files` dir
- Rebuild and run (`make up`)

## Related Resources

* [gatling-test-example](https://github.com/jecklgamis/gatling-test-example) - for generating your perf test traffic
* [envoy-proxy-template](https://github.com/jecklgamis/envoy-proxy-template) - for spinning up your own Envoy proxy
  server