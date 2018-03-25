### Scenario 1 & 2 Documentation
Scenario one and two requires secure communication channels to be created between three containers that are all on the same operating system/machine. Container 1 must only directly communicate with container 2 with and container3 and only communicate directly with container 2.

The setup for the starting all the containers is below. (/setup.sh)
```
#!/bin/bash
cd container1/ && make build && make start
cd ../
cd container2/ && make build && make start
cd ../
cd container3/ && make build && make start
docker network create ssh_network_1
docker network create ssh_network_2
docker network connect ssh_network_1 container1.cont
docker network connect ssh_network_1 container2.cont
docker network connect ssh_network_2 container2.cont
docker network connect ssh_network_2 container3.cont
```
This builds and starts each container, and creates docker networks to insure the containers can be addressed by their container name, and that container 1 cannot directly communicate with container 3. Each container is an Ubuntu 16.04 machine that has SSH enabled and listening. The root password for each instance is password.

Once this is setup file is run, the scenario script can be executed.
```
#!/bin/bash
ssh -t localhost -p 4444 /root/scp.sh (/scenario_one_and_two_ssh.sh)
```

When this script is run, it connects to the first docker container via SSH, and starts the scp.sh script.
```
#!/bin/bash
scp /root/testfile root@container3.cont:/root/testfile
```

This script initiates the actual communication described above. The reason it specifies container3.cont is because ProxyCommand is in use. This allows for scp to work though multiple ssh hops, as that is not typically a feature of scp tools. The below config is added to the ssh config of container 1.

```
Host container3.cont
  User          root
  HostName      container3.cont
  ProxyCommand  ssh root@container2.cont nc %h %p 2> /dev/null
```


 So when you run the scenario script, you will:
 ```
 1. Start a script on the first container1
 2. That script will try to initiate a connection with container3.cont
 3. SSH will realize container3 is in the config file, and ProxyCommand will proxy through container2
 4. container1 will establish a connection with container2 via SSH and start a script on container2.
 5. The script on container2 will establish a ssh connection with container3
 6. The SSH chain will have been established, and the original SCP command on container1 will allow a file transfer from container1 to container3 through container2 via SSH/SCP.
 ```
