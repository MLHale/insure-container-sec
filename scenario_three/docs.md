### Scenario 3 Documentation
Scenario three requires secure communication channels to be created between three containers. There must be one container on one virtual machine, and two on another virtual machine. Both virtual machines are required to be on the same hypervisor, but this does not come in to play with the way this is setup. Container 1 must only directly communicate with container 2. Container 3 must only directly communicate with container 2.

The setup script for  first virtual machine is below. (/setup.sh) It takes two arguments, the ip address of the second virtual machine, and the port on the virtual machine that forwards to the SSH service of Container 2.
```
#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: ./setup.sh [ip of second vm running on same hypervisor] [port on vm that forwards to ssh service on container ]"
fi


echo Host container3.cont > container1/config
echo "  User          root" >> container1/config
echo "  HostName      container3.cont" >> container1/config
echo "  ProxyCommand  ssh root@$1 -p $2 nc %h %p 2> /dev/null" >> container1/config

cd container1/ && make build && make start
```


The setup script for the second virtual machine is below. It creates a docker network, builds, and starts Containers 2 and 3.
```
#!/bin/bash
cd container2/ && make build && make start
cd ../
cd container3/ && make build && make start
docker network create ssh_network_1
docker network connect ssh_network_1 container2.cont
docker network connect ssh_network_1 container3.cont
```

Once both setup scripts have been executed, the scenario script can be run. This should be done on the first virtual machine. (setup.sh)
```
#!/bin/bash
ssh -t localhost -p 4444 /root/scp.sh
```

When this script above is ran, it connects to the first docker container via SSH, and starts the scp.sh script.
```
#!/bin/bash
scp /root/testfile root@container3.cont:/root/testfile
```

This script initiates the actual communication described above. The reason it specifies container3.cont is because ProxyCommand is in use. This allows for scp to work though multiple ssh hops, as that is not typically a feature of scp tools. The below config is added to the ssh config of container 1 when the setup script is ran.
```
Host container3.cont
  User          root
  HostName      container3.cont
  ProxyCommand  ssh root@{container 2 ip} -p {container 2 port} nc %h %p 2> /dev/null"
```

 So when you run the scenario script, you will:
 ```
 1. Start a script on Container 1
 2. That script will try to initiate a connection with container3.cont
 3. SSH will realize container3.cont is in the SSH config file, and ProxyCommand will proxy through Container 2, since its IP and port are specified.
 4. Container 1 will establish a connection with Container 2 via SSH and start a script on Container 2.
 5. The script on Container 2 will establish a ssh connection with Container 3
 6. The SSH chain will have been established, and the original SCP command on container1 will allow a file transfer from Container 1 to Container 3 through Container 2 via SSH/SCP.
 ```
