# Milestone 3

# Project Realization

The team has focused primarly on architecting a test platform to be able to test various containers whether they are local or remote. The team took into condersation some various features that could be lost based on the tool that is being implemented.


### Test platform Architecture

The team has thoughtout the basic architecture of the test platform. Each tool that will be implemented in its own container that is then forwarded to a master container that will contain test results from each tool. Below is a break down of how each tool was implemented.

# Nmap

# Container Advisor (cAdvisor)

cAdvisor it provides an in-depth understanding of performance characteristics and resource usage of containers. In which, this data would be beneficial for a Security expert to analyze the data and spot abnormalities in containers that could be an indicator of compromise.

### cAdvisor implemetation:

1. On a linux box run
2. mkdir cAdvisor
3. vim Dockerfile

```
From alpine:3.4

ENV GLIBC_VERSION "2.23-r3"

FROM golang:latest

RUN apt-get update && apt-get install -y git dmsetup && apt-get clean
RUN git clone https://github.com/google/cadvisor.git /go/src/github.com/google/cadvisor
RUN cd /go/src/github.com/google/cadvisor && make
ENTRYPOINT ["/go/src/github.com/google/cadvisor/cadvisor"]
```

4.Then vim Makefile

```
build: Dockerfile *
	docker build -t cadvisor.img .

start: build
	-docker run -d -p 8888:22 -t --name cadvisor.cont cadvisor.img

stop:
	-docker container stop cadvisor.cont

clean:
	-docker container stop cadvisor.cont
	-docker container rm cadvisor.cont
```

  a. The Makefile is utilize to stand up the container, start it, stop, and clean it if needed to.


5. Now Run 'make Run'

6. To ensure the container is running run:

	a. Docker ps --to list containers that are currently running

7.Run:

  a. sudo docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:latest

8. Now navigate to the machine's ipaddress:8080 to view cAdvisor and start analyzing the containers being run.

    a. 137.48.191.120:8080 in our scenario.



# OpenVas
