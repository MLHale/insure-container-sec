# Milestone 2 (Due March 26, 2018)

# Project Realization - Overview

Thus far, the team has been working towards completing both part one and part two of the project.

To recap the two parts of the project -
- Part 1 (Secure Communication Amongst Containers): Using NSA scenarios, verify SSH capabilities between containers located on different VMs.
- Part 2 (Container Verification Configuration as a Container): Create a script that can be run from a Docker container to test another Docker container for predetermined vulnerabilities.

### Progress

The team has nearly finished part one of the project in its entirety.  Over the past weeks, they created four Docker containers with SSH capabilities and have establishes three Ubuntu 16.04 virtual machines.  These virtual machines are running on two different ESXI hypervisors as requested by the project sponsor.  To simplify the transfer of the data file between multiple containers, the SSH ProxyCommand configuration option has been utilized.  A bash script has been written for each specific scenario.

While the team has been focusing on completing Part 1, they have also determined a baseline of what they want to test for in Part 2.  They will be running tests from each of the seven sections in the "CIS Ubuntu Linux 16.04 LTS Benchmark" document.  Specifically, these 6 categories -

* Filesystem Configuration
* Services
* Network Configuration
* Logging and Auditing
* Access, Authentication and Authorization
* System Maintenance

These will be split into two seperate catagories -

* Server
* Workstation

Other tests will include utilizing OpenVas to enumerate any existing vulnerabilities, and nmap to enumerate open ports and service versions.

### Outcomes

The progress outcomes referenced above are summarized by the bullets below.
* Established three VMs on two different ESXI Hypervisors
* Implemented the four outlined scenarios utilizing Docker
* Determined a baseline to begin Part 2 of the project

### Hindrances

Thus far, we have had a total of 2.5 project changes.  Unfortunately, this set us back a bit at the beginning.  The only other hinderance we ran into was miscommunication with our project sponsor about Part 2 of our project.

### Ongoing Risks

Most of our risks have remained the same throughout the semester.  The only change we have seen is removing the possibility of being unable to replicate the CAVES model.  You can see this change in the table below.

| Risk       | Description of Risk | Likelihood | Impact Factor |
| ---------- | ------------------- | ---------- | ------------- |
| Lack of skill set (3) | Group has an overall lack of experience with a given skill, hindering project efficiency.| 1 | 3 |
| Team member availability (8) | Group is unable to meet at the same time as the class meets at different sessions for graduates and undergraduates. | 2 | 4 |
| ~~Unable to obtain or replicate CAVES model. (12)~~| ~~The team is unable to create/obtain a VM that follows the CAVES model for testing.~~| ~~3~~| ~~4~~ |
| Scope creep (28) | Unable to test all desired vulnerabilities due to lack of time. | 4 | 7 |
| Divergence in goals (10) | Team and sponsor begin to picture different goals for project as time progresses. | 5 | 2 |

# Technical Implementation

### Setup
The setup process started with hosting a Ubuntu 16.04 virtual machine at UNO. Docker was installed using:
```
apt-get install docker.io
```

Dockerfiles are what are utilized to actually build and create containers with docker. All of the Dockerfiles for each scenario and container are  extremely similar. When built, they all create Ubuntu 16.04 containers, with ssh installed and listening on port 22. The root password for each container is "password". There are some slight modifications of some Dockerfiles to add certain configurations and files when need.

 ![sampleDockerfile](/Diagrams/sampleDockerfile.png "sampleDockerfile")

Additionally, to make things easy, Makefiles were created for each containers. This makes building, stoping, and removing containers easy.


Below are the scenarios that were needed to be designed and implemented secure communication amongst them all.

### Scenario 1
For details on how to setup scenario one and two, please refer to the [documentation](/scenario_one_and_two/docs.md).
![vmorginal](/assets/scenario.png "vm on architecture")


### Scenario 2
For details on how to setup scenario one and two, please refer to the [documentation](/scenario_one_and_two/docs.md).
![vm1](/assets/VM1.png "1vm on hypervisor")

### Scenario 3
For details on how to setup scenario three, please refer to the [documentation](/scenario_three/docs.md).
![2vms](/Diagrams/2vms.png "2vms on same hypervisor")

### Scenario 4
For details on how to setup scenario four, please refer to the [documentation](/scenario_four/docs.md).
![3vms](/Diagrams/3vms.png "3vms on different hypervisors")

### CCVAS
![testplan](/Diagrams/testplan.png "Containers high-level")

### Next Milestone Planning

The team will create a container that will be utilized for testing other containers. This container will be able to scan either local or remote containers. Some features may be lost if not scanning locally. For example, the CIS Docker benchmark does not actually scan individual containers, but rather insures the host operating system is set up to securely host docker containers. Additionally, the team will further research potential tools to include in the container that will run on the container that will be tested. As an example, the testing container we create will be used to test one of the containers in the initial scenarios.

The updated Kanban board can be viewed below:
![kanban](/assets/kanban2.0.PNG "Updated Kanban")
