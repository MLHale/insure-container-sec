### Scenario 4 Documentation
Scenario four requires secure communication channels to be created between four containers. There must be one container (Container 1) on one virtual machine, two containers on another virtual machine (Container 2 & 3). Both of these virtual machines are required to be on the same hypervisor. A third virtual machine with one container (Container 4) running on another hypervisor must also be used. Container 1 must only directly communicate with Container 2. Container 2 must only directly communicate with Container 1 and Container 3. Container 3 must only directly communicate with Container 2 and Container 4. Container 4 must only directly communicate with Container 3.

The setup script for first virtual machine is below. (/setup.sh) It takes four arguments, the ip address of the second virtual machine (with Container 2 & 3), the port on the second virtual machine that forwards to the SSH service of Container 2, the ip address of the third virtual machine (with Container 4), and the port on the third virtual machine that forwards to the SSH service of Container 4.

```
#!/bin/bash
if [ "$#" -ne 4 ]; then
    echo "Usage: ./setup.sh [ip of second vm running on same hypervisor] [port on vm that forwards to ssh service on container ] [ip of third vm running on different hypervisor] [port on last vm]"
    exit
fi

echo Host container3.cont > container1/config
echo "  User          root" >> container1/config
echo "  HostName      container3.cont" >> container1/config
echo "  ProxyCommand  ssh root@$1 -p $2 -W %h:%p" >> container1/config

echo Host $3 >> container1/config
echo "  User          root" >> container1/config
echo "  HostName      $3" >> container1/config
echo "  ProxyCommand  ssh root@container3.cont -W %h:%p" >> container1/config

echo "#!/bin/bash" > container1/scp.sh
echo scp -P $4 /root/testfile root@$3:/root/testfile >> container1/scp.sh

cd container1/ && make build && make start

```

The setup script for the second virtual machine is below. It creates a docker network, builds, and starts Containers 2 and 3.
```
cd container2/ && make build && make start
cd ../
cd container3/ && make build && make start
docker network create ssh_network_1
docker network connect ssh_network_1 container2.cont
docker network connect ssh_network_1 container3.cont
```

The final setup script for the third VM is below. It simply builds and starts the container.
```
cd container4/ && make build && make start
```

Once both setup scripts have been executed, the scenario script can be run. This should be done on the first virtual machine. (scenario_4.sh)
```
#!/bin/bash
ssh -t localhost -p 4444 /root/scp.sh
```

When this script above is ran, it connects to the first docker container via SSH, and starts the scp.sh script.
```
#!/bin/bash
scp /root/testfile root@{VM 3 ip}:/root/testfile
```

This script initiates the actual communication described above. The reason it specifies container3.cont is because ProxyCommand is in use. This allows for scp to work though multiple ssh hops, as that is not typically a feature of scp tools. The below config is added to the ssh config of container 1 when the setup script is ran.
```
Host container3.cont
  User          root
  HostName      container3.cont
  ProxyCommand  ssh root@{VM 2 ip} -p {Container 2 forwarding port} -W %h:%p

Host {VM 3 ip}
  User          root
  HostName      {VM 3 ip}
  ProxyCommand  ssh root@container3.cont -W %h:%p
```

 So when you run the scenario script, you will:
 ```
 1. Start a script on Container 1
 2. That script will try to initiate a connection with VM 3/Container 4
 3. SSH will realize VM 3/Container 4 is in the SSH config file, and ProxyCommand will proxy through container3.cont.
 4. SSH will realize container3.cont is in the SSH config file and ProxyCommand will proxy through the ip address of container 2.
 5. Container 1 will establish a connection with Container 2 via SSH.
 6. Container 2 will establish a connection with Container 3 via SSH.
 7. Container 3 will establish a connection with Container 4 via SSH.
 8. The SSH chain will have been established, and the original SCP command on container1 will allow a file transfer from Container 1 to Container 3 through Container 2 via SSH/SCP.
 ```
