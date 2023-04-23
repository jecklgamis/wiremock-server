IMAGE_NAME:=jecklgamis/wiremock-server
IMAGE_TAG:=main

default:
	@cat ./Makefile
image:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .
run:
	docker run -p 8080:8080 $(IMAGE_NAME):$(IMAGE_TAG)
run-bash:
	docker run -i -t $(IMAGE_NAME):$(IMAGE_TAG) /bin/bash
exec-bash:
	docker exec -it `docker ps | grep $(IMAGE_NAME) | awk '{print $$1}'` /bin/bash
all: image
up: image run
