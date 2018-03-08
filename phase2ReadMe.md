# Technical Implementation

The team has broked down the technical portion in two parts: the setup of the containers then testing.

### Setup
The setup process started with hosting a linux virutal machine at UNO from which docker was installed along with three containers. The tree containers were setup to have a secure communication channel amongst them. Then cloning that VM to another one on the same hypervisor then again to another hypervisors.

Below are detailed steps to how Docker was setup along installing the containers:
1. SSH to 137.48.251.97 with username Capstone and authenticate with the public key
2. Run: apt-get install docker.io
3. cd /home/capstone/ and create containers directories
4. Below is a sample of the Dockerfile (necessary to generate containers) that was created for the first senario container 1.![sampleDockerfile](/Diagrams/sampleDockerfile.png "sampleDockerfile")

  1. Please note, the Dockerfile initaites port 22 to be open to create a secure channel amongst the contaiers.

Below are the senarios that were needed to be designed and needed to be tested that secure communication is working properly amongst them all.

-- need to discuss more about the different senarios and hypervisors
![vmorginal](/Diagrams/vmorginal.png "vm on architecture")

![vm1](/Diagrams/vm1.png "1vm on hypervisor")

![2vms](/Diagrams/2vms.png "2vms on same hypervisor")

![3vms](/Diagrams/3vms.png "3vms on different hypervisors")

![testplan](/Diagrams/testplan.png "Containers high-level")
