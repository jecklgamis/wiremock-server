# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Dockerized WireMock standalone server for serving canned API responses in functional and performance testing. No application source code — this is purely configuration and container orchestration around WireMock 3.13.1 on Java 21 / Ubuntu 24.04.

## Build & Run Commands

```bash
make image        # Build Docker image
make run          # Run container (port 8080)
make up           # Build and run (image + run)
make run-bash     # Run container with bash shell
make exec-bash    # Exec bash into running container
```

Verify with: `curl http://localhost:8080/`

## Architecture

- `mappings/` — WireMock request mapping JSON files (define URL patterns, methods, and response behavior)
- `__files/` — Response body files referenced by `bodyFileName` in mappings
- `Dockerfile` — Builds image: Ubuntu 24.04 + JDK 21 + WireMock standalone JAR
- `docker-entrypoint.sh` — Launches WireMock with tuned JVM/Jetty settings (1G heap, 1024 container threads, async responses with 64 threads, request journal disabled)

## Adding New Mock Endpoints

1. Create a mapping file in `mappings/` (JSON matching WireMock's stub mapping format)
2. If the response has a body, add the response file in `__files/` and reference it via `bodyFileName`
3. Rebuild with `make up`

## Key Environment Variables (in container)

- `WIREMOCK_VERSION` — WireMock JAR version (currently 3.13.2)
- `WIREMOCK_HOME` — `/wiremock`
- `WIREMOCK_PORT` — Default 8080
- `WIREMOCK_ARGS` — Additional WireMock CLI arguments
- `JAVA_OPTS` — JVM options

## CI/CD

GitHub Actions (`.github/workflows/build.yml`) builds and pushes the Docker image to Docker Hub on pushes to main and version tags. PRs trigger build only (no push).
