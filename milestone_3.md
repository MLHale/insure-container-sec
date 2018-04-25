# Container Configuration Verification as a Container (CCVAC)

Milestone 3

Due May 4, 2018

# Executive Summary

In today’s world, the use of virtual machines in daily business operations has become prolific.  Virtual machines can greatly enhance the efficiency of a business and drastically reduce costs associated with purchases of physical machines, energy consumption and cooling. Consequently, as the adoption of virtual environments continues to grow, so does the concern of their security.  Similarly, an organization's increased dependence on virtual infrastructure increases the possible attack vectors accessible to malicious actors. A single security breach caused by poor configurations can end up costing organizations much more than they saved by switching to virtual infrastructure.

As organizations move operations to virtual environments, they need tools to ensure that they are being properly utilized. The completion of “Container Configuration Verification as a Container” (CCVAS) will provide a method to evaluate systems that use a virtualization technology known as containers. In particular, CCVAS will try to solve the security problems faced when establishing and utilizing Docker. The end project deliverable will be a container that evaluates the security of other containers. This provides a simplified solution that can help reduce organizations’ risk when operating in virtual environments.

The completion of CCVAS will look to achieve the following list of goals:
* Establish and leverage VMs and containers to test SSH against sponsor provided scenarios.
* Determine efficiency of SSH in each scenario.
* Develop a set of scripts and commands that will test for vulnerabilities.
* Run test scripts against target containers.
* Create an HTTP server hosting test results.

# Project Overview

Over the course of this semester, the team has worked intensively with Docker to fulfill the goals associated with the CCVAC project.  The project was composed of two parts, namley Secure Communication Amongst Containers and Container Verification as a Container.  Specifically, Secure Communication Amongst Containers verified SSH capabilites by utilizing four predetermined scenarios obtained from the team sponsor.  The Container Verification as a Container aspect of the project was established with purpose of leveraging a series of containers to run test scripts against other Docker containers.  These test scripts would locate security issues found in the configurations of the host containers.  Results of these efforts can be seen below. 

# Project Realization

UPDATE ONCE PROJECT IS FINALIZED

Part one of the project, Secure Communication Amongst Containers, was completed during the first milestone. Thus, the past few weeks, the team has focused primarly on architecting a cummulative testing platform to scan various containers, whether they are local or remote. The "CIS Ubuntu Linux 16.04 LTS Benchmark" document was used to establish a baseline for the test containers.  The team has created X AMOUTN OF CONTAINERS.  X of the containers are relevant to nearly all systems, and the remaining containers run tests more specific to Ubuntu systems.  It was the goal of the team to create containers that would detect some of the most basic security issues that could be encountered when working with Docker containers.  Upon creating the test containers, a "master container" was established to run the test containers and produce an output document that displays test results.

# Project Methodology

**User Stories**<br>
In order to determine the best path for the project, some important user stories were identified. Those were:

```As a security professional, I want to confirm my organization's containers are secure, so there is no unauthorized information disclosure.```


```As a security professional, I want a automated tool to confirm the security of containers, so I can improve my efficiency and focus efforts elsewhere.```

**Literature Review**<br>
Relevant research papers have been identified. These are listed in the "Relevant Literature" section below. These each somehow touch the scope of our project, and will be utilized and referenced when possible for the duration of our project.

**Technical Plan**<br>
Our general plan is to create a Docker container, composed of other Docker containers and components. Each component will complete a dedicated security related task. Components will use existing scripts and tools when possible to evaluate targets.  Currently, we plan to run tests such as nmap and OWASP Top 10 to discover any possible configuration vulnerabilities. Docker files will be checked for configuration issues and threats. Scripts to use these tools will be written in bash and python. Any important output will be sent up to the component caller, where it will be added to a report. This report will be a consolidation of all the important data and output in a PDF file.

To scan a target, a configuration file will be specified and ingested by the scanning container.

# Results

Upon culmination of this semester, the team fully completed CCVAC.  The conclusion of the project saw the achievement of all goals listed above.  Specifically, the team successfully implemented all four SSH scenarios requested by the team sponsor.  Upon

Summary of results here

**Outcomes**


## Getting Started 

The setup process started with hosting a Ubuntu 16.04 virtual machine at UNO. Docker was installed using:
```
apt-get install docker.io
```

Dockerfiles are what are utilized to actually build and create containers with docker. All of the Dockerfiles for each scenario and container are  extremely similar. When built, they all create Ubuntu 16.04 containers, with ssh installed and listening on port 22. The root password for each container is "password". There are some slight modifications of some Dockerfiles to add certain configurations and files when need.

 ![sampleDockerfile](/Diagrams/sampleDockerfile.png "sampleDockerfile")

Additionally, to make things easy, Makefiles were created for each containers. This makes building, stoping, and removing containers easy.

## Secure Communication Amongst Containers Architecture

Specific documentation, including setup and how to run each scenario, can be found in the docs.md files in each scenario directory.

**Scenario One and Two -** The first two scenarios simply require SSH communication between three containers that are all running on the same operating system/machine.  Container 1 must only directly communicate with container 2 with and container3 and only communicate directly with container 2.

**Scenario One**

![vmorginal](/assets/scenario.png "vm on architecture")

**Scenario two**

![vm1](/assets/VM1.png "1vm on hypervisor")

**Scenario Three -** Similar to scenarios one and two, scenario three requires secure communication between three containers.  However, one container is on one machine, while the other two are on another.  Both machines are run on the same hypervisor.   Container 1 must only directly communicate with container 2. Container 3 must only directly communicate with container 2.
![2vms](/Diagrams/2vms.png "2vms on same hypervisor")


**Scenario Four -** Scenario four requires secure communication channels to be created between four containers. There must be one container (Container 1) on one virtual machine, two containers on another virtual machine (containers 2 & 3). Both of these virtual machines are required to be on the same hypervisor. A third virtual machine with one container (Container 4) running on another hypervisor must also be used. Container 1 must only directly communicate with Container 2. Container 2 must only directly communicate with Container 1 and Container 3. Container 3 must only directly communicate with Container 2 and Container 4. Container 4 must only directly communicate with Container 3.
![3vms](/Diagrams/3vms.png "3vms on different hypervisors")

### Secure Communication Amongst Containers Results

By use of the previous architecture, the team was able to fulfill each of the four scenarios described above.  In addition to proving SSH capabilites for each scenario, the team also determined the efficiency of each scenario.  For each scenario, the same one gigabyte text file was sent via SCP.  Specific findings are discussed below.

**Scenario One and Two -** Transferred a 1GB file, The file was transferred in 0.1 seconds.  The file was sent at a speed of 17259.09 bytes per second and was received at a speed of 22673.3 bytes per second.

**Scenario Three -** Transferred a 1GB file, The file was transferred in 0.1 seconds.  The file was sent at a speed of 26659.3 bytes per second and was received at a speed of 35381.2 bytes per second.

**Scenario Four-** Transferred a 1GB file, The file was transferred in 32.9 seconds.  The file was sent at a speed of 30402188.4 bytes per second and was received at a speed of 5130.4 bytes per second.

The results of file transfer speed are surprising. As noted above, the file was transferred in nearly same amount of time in scenarios one and two and three. However, unlike scenarios one and two, scenario three required the file to be transferred to another VM.  Thus, the fact it took approximately 32.8 more seconds to transfer between three VMs in scenario four is an anomaly.

## Test Platform Architecture

The team greatly considered the basic architecture of the test platform. Each tool that will be implemented in its own container that is then run from to a master container that will contain test results from each tool. Below is a break down of how each tool was implemented.

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



### OpenVAS
OpenVAS is an open source vulnerability scanning tool. This will be utilized to perform a vulnerabiliity assessment provided an ip address that will be scanned. The team will utilize OpenVAS command line option through omp commands through the following structure. 

### Ubuntu

The Ubuntu container will only be called upon by the master container if the target machines run a Ubuntu operating system.  Users running the master container will have the option to enter "yes" or "no" when prompted whether or not the target machine is running Ubuntu.  If the users enter "no", the master container will skip over this script.  Thus, the Ubuntu script will not be impletmented as a script, but will be copied into the master container when necessary.  The Ubuntu script can be found in the X CONTAINER under benchmark.sh file.

### Docker

Docker benchmark stuff  --> just a script

## Qualifications

This team consists of two graduate students and three undergrad students from the University of Nebraska – Omaha.  Each member of the team brings unique technical skills and past experiences, giving the team a diverse background.  A detailed description of each team member can be found below.

* Kerolos Lotfy is an experienced in Cyber Security professional with a demonstrated history of conducting penetration tests and source code reviews. Skilled in application, network, and operating system security risks. Along with technical risk assessments, vulnerability management, and remediation. Kerolos, is also published in the 2016 IEEE International Conference on Mobile Services titled “Assessing Pairing and Data Exchange Mechanism Security in the Wearable Internet of Things.” Currently finishing up Masters of Science(MS) in Cybersecurity, with an undergraduate degree in Information Assurance with a minor in Computer Science.

* Alisa Bohac is an undergraduate student at the University of Nebraska Omaha (UNO).  She will graduate from UNO in May 2018 with a B.S. in Cybersecurity and a minor in Computer Science.  Throughout her time as an undergrad, she has held technical positions in two industries, namely software and defense contracting.  She interned at a local software company where she worked with the software engineering team on a credit card processing system.  Furthermore, she spent the past summer in Lexington, Massachusetts, as a part MIT Lincoln Laboratory’s cyber division.  While at Lincoln, she created an encrypted communication channel for a DoD system.  Finally, she was a recipient of the Walter Scott, Jr. Scholarship and was a member of the Scott Scholar community throughout college.  Her interests include penetration testing and digital forensics.

* Dan Ritter is a graduate student at the University of Nebraska Omaha seeking a MS in Cybersecurity, which he is expected to graduate with in May 2018. He graduated with a BS in Cybersecurity with a Computer Science minor in May 2017, after just three years. He is currently President of NULLify, UNO’s cybersecurity club. He was a computer science tutor for one year before becoming a Security Analyst Intern at Gallup. His Gallup role has since transformed into a regular part-time role, and will become a full-time role in June. He is currently working on his OSCP certification. Dan’s interest include pen testing, network security, and concepts related to reverse engineering.

* Michael Keck is a undergraduate student at the University of Nebraska Omaha studying Cyber Security and Computer Science.  While his professional background is not in Cyber Security or Computer Science, Michael has ten years of military experience with which has contributed to personable skills such as leadership, working in a group to accomplish a common goal, and being a overall badass.  Michael is currently working on learning more about Cyber Security through classes at the university and also on his own time.  His interest is in digital and mobile forensics, industrial control systems, and penetration testing.  Michael is will be graduating fall 2018.

* Alexander G. Diaz is a undergraduate student at the University of Omaha at Nebraska and is currently enrolled in the Cyber Security program with an expected graduation date in the Fall of 2018. He is currently working on his Security+ Certification, which should be completed by May 2018. His interest in Cyber Security developed from an desire to harden infrastructure systems against attacks, and is therefore interested in code hardening, digital forensics, and digital industrial systems.

### Contact

- Kerolos Lotfy (klotfy@unomaha.edu)
- Dan Ritter (danielritter@unomaha.edu)
- Michael Keck (michaelkeck@unomaha.edu)
- Alisa Bohac (abohac@unomaha.edu)
- Alexander Diaz (agdiaz@unomaha.edu)

