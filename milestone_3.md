# Container Configuration Verification as a Container (CCVAC)

Milestone 3

Due May 4, 2018

# Executive Summary

In today’s world, the use of virtual machines in daily business operations has become prolific.  Virtual machines can greatly enhance the efficiency of a business and drastically reduce costs associated with purchases of physical machines, energy consumption and cooling. Consequently, as the adoption of virtual environments continues to grow, so does the concern of their security.  Similarly, an organization's increased dependence on virtual infrastructure increases the possible attack vectors accessible to malicious actors. A single security breach caused by poor configurations can end up costing organizations much more than they saved by switching to virtual infrastructure.

As organizations move operations to virtual environments, they need tools to ensure that they are being properly utilized. The completion of “Container Configuration Verification as a Container” (CCVAS) will provide a method to evaluate systems that use a virtualization technology known as containers. In particular, CCVAS will try to solve the security problems faced when establishing and utilizing Docker. The end project deliverable will be a container that evaluates the security of other containers. This provides a simplified solution that can help reduce organizations’ risk when operating in virtual environments.

The completion of CCVAS will look to achieve the following list of goals:
- Determine a list of common Docker configurations that leave virtual environments vulnerable to attack.
* Develop a set of scripts and commands that will test for vulnerabilities.
* Test created scripts and selected commands against a container that implements CAVES.
* Generate a PDF report documenting findings of tested containers.

# Project Overview

Over the course of this semester, the team has worked intensively with Docker to fulfill the goals associated with the CCVAC project.  The project was composed of two parts, namley Secure Communication Amongst Containers and Container Verification as a Container.  Specifically, Secure Communication Amongst Containers verified SSH capabilites by utilizing four predetermined scenarios obtained from the team sponsor.  The Container Verification as a Container aspect of the project was established with purpose of leveraging a series of containers to run test scripts against other Docker containers.  These test scripts would locate security issues found in the configurations of the host containers.  Results of these efforts can be seen below. 

# Project Realization

Part one of the project, Secure Communication Amongst Containers, was completed during the first milestone. Thus, the past few weeks, the team has focused primarly on architecting a cummulative testing platform to scan various containers, whether they are local or remote. The "CIS Ubuntu Linux 16.04 LTS Benchmark" document was used to establish a baseline for the test containers.  The team has created X AMOUTN OF CONTAINERS.  X of the containers are relevant to nearly all systems, and the remaining containers run tests more specific to Ubuntu systems.  It was the goal of the team to create containers that would detect some of the most basic security issues that could be encountered when working with Docker containers.  Upon creating the test containers, a "master container" was established to run the test containers and produce an output document that displays test results.

## Test platform Architecture

The team has thoughtout the basic architecture of the test platform. Each tool that will be implemented in its own container that is then forwarded to a master container that will contain test results from each tool. Below is a break down of how each tool was implemented.

### Nmap

### Container Advisor (cAdvisor)

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

7. Run:

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



### OpenVas

### Ubuntu
