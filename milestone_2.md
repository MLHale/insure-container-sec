# Milestone 2 (Due March 26, 2018)

# Project Realization - Overview

Thus far, the team has been working towards completing both part one and part two of the project.  

To recap the two parts of the project -
- Part 1 (Secure Communication Amongst Containers): Using NSA scenarios, verify SSH capabilities between containers located on different VMs.
- Part 2 (Container Verification Configuration as a Container): Create a script that can be run from a Docker container to test another Docker container for predetermined vulnerabilities.

### Progress

The team has nearly finished part one of the project in its entirety.  Over the past weeks, they created four Docker containers with SSH capabilties and have establishes three Ubuntu 16.04 virtual machines.  These virtual machines are running on two different ESXI hypervisors as requested by the project sponsor.  To simplify the transfer of the data file between multiple containers, the SSH ProxyCommand configuration option has been utilized.  A bash script has been written for each specific scenario.

While the team has been focusing on completing Part 1, they have also determined a baseline of what they want to test for in Part 2.  They will be running tests from each of the seven sections in the "CIS Docker Community Edition Benchmark v1.0" document.  Specifically, these seven categories include -

* Host Configuration
* Docker Daemon Configuration
* Docker Daemon Configuration Files
* Container Images and Build File
* Container Runtime
* Docker Security Operations
* Docker Swarm Configuration

### Outcomes

The progress outcomes referneced above are summarized by the bullets below.
* Established three VMs on two different ESXI Hypervisors
* Created four Docker containers
* Created a Bash script to satisfy each of the four NSA scenarios
* Determined a baseline to begin Part 2 of the project

### Hinderances

Thus far, we have had a total of 2.5 project changes.  Unfortuantley, this set us back a bit at the beginning.  The only other hinderance we ran into was miscommunication with our project sponsor about Part 2 of our project.

### Ongoing Risks

Most of our risks have remained the same throughout the semseter.  The only change we have seen is removing the possibility of being unable to replicate the CAVES model.  You can see this change in the table below.

| Risk       | Description of Risk | Likelihood | Impact Factor |
| ---------- | ------------------- | ---------- | ------------- |
| Lack of skill set (3) | Group has an overall lack of experience with a given skill, hindering project efficiency.| 1 | 3 |
| Team member availability (8) | Group is unable to meet at the same time as the class meets at different sessions for graduates and undergraduates. | 2 | 4 |
| ~~Unable to obtain or replicate CAVES model. (12)~~| ~~The team is unable to create/obtain a VM that follows the CAVES model for testing.~~| ~~3~~| ~~4~~ |
| Scope creep (28) | Unable to test all desired vulnerabilities due to lack of time. | 4 | 7 |
| Divergence in goals (10) | Team and sponsor begin to picture different goals for project as time progresses. | 5 | 2 |

# Technical Implementation

The team has broked down the technical portion in two parts: the setup of the containers then testing.

### Setup
The setup process started with hosting a Linux virutal machine at UNO from which Docker was installed along with four containers. The four containers were setup to have a secure communication channel amongst them.  That VM was then cloned to another one on the same hypervisor then again to another hypervisor.

Below are detailed steps to how Docker was setup along installing the containers:
1. SSH to 137.48.251.97 with username Capstone and authenticate with the public key
2. Run: apt-get install docker.io
3. cd /home/capstone/ and create containers directories
4. Below is a sample of the Dockerfile (necessary to generate containers) that was created for the first senario container 1.![sampleDockerfile](/Diagrams/sampleDockerfile.png "sampleDockerfile")

  1. Please note, the Dockerfile initiates port 22 to create a secure channel amongst the containers.

Below are the senarios that were needed to be designed and implementated secure communication amongst them all.

-- need to discuss more about the different senarios and hypervisors
### Scenario 1
For details on how to setup scenario one and two, please refer to the [documentation](/scenario_one_and_two/docs.md).
![vmorginal](/Diagrams/vmorginal.png "vm on architecture")


### Scenario 2
For details on how to setup scenario one and two, please refer to the [documentation](/scenario_one_and_two/docs.md).
![vm1](/Diagrams/vm1.png "1vm on hypervisor")

### Scenario 3
For details on how to setup scenario three, please refer to the [documentation](/scenario_three/docs.md).
![2vms](/Diagrams/2vms.png "2vms on same hypervisor")

### Scenario 4
For details on how to setup scenario four, please refer to the [documentation](/scenario_four/docs.md).
![3vms](/Diagrams/3vms.png "3vms on different hypervisors")

### CCVAS
![testplan](/Diagrams/testplan.png "Containers high-level")

### Next Milestone Planning

The team will stand up another container that will be utilized for testing other containers. To do so the team will further research potential tools to include in the container that will run on the containter that will be tested.

Potential Tools:
 1. OpenVas vulnerability scanning
    - Utilzies the current CVE for Ubuntu to test against all known vulnerabilties
 2. nmap
 3. CIS Benchmark (Ubuntu 16.04, Docker)

The plan is to implement those tools and run them against a potential container for finding potential vulnerabilities. In which those findings would be benefial for our project partenter. As they could take this container and test any container they have for potential vulnerabilities.

The team would utilzie the test container to test one of the containers in the initial scenariors that were setup.

The updated Kanban board can be viewed below:
![kanban](/assets/kanban2.0.PNG "Updated Kanban")
