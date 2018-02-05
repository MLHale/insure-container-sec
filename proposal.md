**Introduction**

The completion of “Container Configuration Verification as a Container” (CCVAS) will provide a secure method to configure the requirements for the network bridged files, methods to instantiate containers, and secure communications for applications when working in a virtual environment.  CCVAS will utilize Docker containers to solve the current security problem faced when establishing and utilizing virtualization software.  The end project will provide both a simplified solution and reduce organizations’ risk when operating in a virtual environment.

**Problem Statement**

In today’s world, the use of virtual machines in daily business operations has become prolific.  Virtual machines can greatly enhance the efficiency of a business and drastically reduces costs by removing the necessity to purchase physical machines, cutting energy and cooling consumption, and improving recovery operations.  Consequently, as the adoption of virtual environments continues to grow, so does the concern of their security.  The more organizations come to rely on virtual systems, the more these systems will become targets of security attacks.  While using virtual systems can save a large amount of money, a security breach due to poor configurations can end up costing organizations much more than they saved.  Therefore, as organizations move operations to virtual environments, they need tools to ensure that they are being properly utilized. Thus, CCVAS will look to bridge the gap between security and virtualization.

**Project Goals**

The completion of CCVAS will look to achieve the following list of goals.  Each of these goals will work towards better security for a virtual environment.
* Determine a list of common Docker configurations that leave virtual environments vulnerable to attack.
* Develop a set of scripts and commands that will test for vulnerabilities.
* Test created scripts and selected commands against a container that implements CAVES.
* Generate a PDF report documenting findings of tested containers.

**Project Merit**

Without proper configuration, virtual environments do little to benefit  organizations. They may temporarily save money, but those savings will eventually be offset by costs associated with recovery after an attack. By successfully meeting all proposed goals and fulfilling the plan of action, CCVAS will help organizations determine security threats caused by poor container configurations before malicious users do. Not only will CCVAS help strengthen organization's defenses, but could prevent the loss of confidential information and the financial implications associated with it.  Further, the CCVAS solution will simplify organizations' configuration process by efficiently providing all scripts and solutions in one container.  Thus, CCVAS should be a quick and simplified solution for those utilizing a Docker environment.

**Similar Work**
In 2015 IBM released the Vulnerability Advisor, a service that scans containers for vulnerabilities and flaws in policy. Looking at IBM's product what information professionals are looking for when having their containers inspected for flaws. This includes both known vulnerabilities and policy flaws and notes how serious the threat is.

**Plan of Action**

In order to achieve all of our project goals, the team has created a timeline to help them meet important deadlines.  The following list documents the basic tasks the team aims to meet throughout the weeks.  A more detailed Gantt chart can be referenced below for a week-by-week breakdown of project deadlines.

1. Learn Docker
2. Set up a Docker container
3. Find or create CAVES virtual environment (or similar VMs for testing)
4. Determine what vulnerabilities we need to test for
5. Determine any relevant commands/write scripts to test against designated vulnerabilities
6. Create report functionality
7. Combine all scripts/containers into one large Docker container
8. Write a report which includes research, testing methods, output, and recommendations

**Time Frame**

| Week          | Team focus    |
| ------------- | ------------- |
| 0-3           | Research protocols|
| 4-6           | Conduct test for formal verifications|
| 7-9           | work on report |
| 10            | Project report  |


## Proposed Project Timeline
![Gant Chart](/assets/gant_chart.png "Project Timeline")


**Project Oriented Risks**

Throughout the course of the project, the team will likely experience a variety of risks that threaten to hinder the project's completion.  Likelihood displays a risk factor, and ranks the risks with a value between one and five (one being the most likely to occur and five being the least likely to occur).  The impact factor shows the team's prediction of how bad the given risk will impact the completion of the project.  Impact factor will be ranked with a value between one and ten (one having the least impact on project completion and ten having the most).

| Risk       | Description of Risk | Likelihood | Impact Factor |
| ---------- | ------------------- | ---------- | ------------- |
| Lack of skill set (3) | Group has an overall lack of experience with a given skill, hindering project efficiency.| 1 | 3 |
| Team member availability (8) | Group is unable to meet at the same time. | 2 | 4 |
| Unable to obtain or replicate CAVES model. (12) | The team is unable to create/obtain a VM that follows the CAVES model for testing. | 3 | 4|
| Scope creep | Unable to test all desired vulnerabilities due to lack of time. (28) | 4 | 7 |
| Divergence in goals | Team and sponsor begin to picture different goals for project as time progresses. (10) | 5 | 2 |

**Required Materials**

In order to complete the CCVAC project, the team will need the following materials -

* A central VM (hosted at UNO), to run Docker.  The team will SSH into this machine.
* A CAVES modeled virtual machine to test our container solutions on.

**Qualifications**

This team consists of two graduate students and three undergrad students from the University of Nebraska – Omaha.  Each member of the team brings unique technical skills and past experiences, giving the team a diverse background.  A detailed description of each team member can be found below.

* Kerolos Lotfy is an experienced in Cyber Security professional with a demonstrated history of conducting penetration tests and source code reviews. Skilled in application, network, and operating system security risks. Along with technical risk assessments, vulnerability management, and remediation. Kerolos, is also published in the 2016 IEEE International Conference on Mobile Services titled “Assessing Pairing and Data Exchange Mechanism Security in the Wearable Internet of Things.” Currently finishing up Masters of Science(MS) in Cybersecurity, with an undergraduate degree in Information Assurance with a minor in Computer Science.

* Alisa Bohac is an undergraduate student at the University of Nebraska Omaha (UNO).  She will graduate from UNO in May 2018 with a B.S. in Cybersecurity and a minor in Computer Science.  Throughout her time as an undergrad, she has held technical positions in two industries, namely software and defense contracting.  She interned at a local software company where she worked with the software engineering team on a credit card processing system.  Furthermore, she spent the past summer in Lexington, Massachusetts, as a part MIT Lincoln Laboratory’s cyber division.  While at Lincoln, she created an encrypted communication channel for a DoD system.  Finally, she was a recipient of the Walter Scott, Jr. Scholarship and was a member of the Scott Scholar community throughout college.  Her interests include penetration testing and digital forensics.

* Dan Ritter is a graduate student at the University of Nebraska Omaha seeking a MS in Cybersecurity, which he is expected to graduate with in May 2018. He graduated with a BS in Cybersecurity with a Computer Science minor in May 2017, after just three years. He is currently President of NULLify, UNO’s cybersecurity club. He was a computer science tutor for one year before becoming a Security Analyst Intern at Gallup. His Gallup role has since transformed into a regular part-time role, and will become a full-time role in June. He is currently working on his OSCP certification. Dan’s interest include pen testing, network security, and concepts related to reverse engineering.

* Michael Keck is a undergraduate student at the University of Nebraska Omaha studying Cyber Security and Computer Science.  While his professional background is not in Cyber Security or Computer Science, Michael has ten years of military experience with which has contributed to personable skills such as leadership, working in a group to accomplish a common goal, and being a overall badass.  Michael is currently working on learning more about Cyber Security through classes at the university and also on his own time.  His interest is in digital and mobile forensics, industrial control systems, and penetration testing.  Michael is will be graduating fall 2018.

* Alexander G. Diaz is a undergraduate student at the University of Omaha at Nebraska and is currently enrolled in the Cyber Security program with an expected graduation date in the Fall of 2018. He is currently working on his Security+ Certification, which should be completed by May 2018. His interest in Cyber Security developed from an desire to harden infrastructure systems against attacks, and is therefore interested in code hardening, digital forensics, and digital industrial systems.

**Contact**

- Kerolos Lotfy (klotfy@unomaha.edu)
- Dan Ritter (danielritter@unomaha.edu)
- Michael Keck (michaelkeck@unomaha.edu)
- Alisa Bohac (abohac@unomaha.edu)
- Alexander Diaz (agdiaz@unomaha.edu)
