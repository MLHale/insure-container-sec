#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: ./setup.sh [ip of third vm running on different hypervisor] [port on vm that forwards to ssh service on container]"
fi

echo "#!/bin/bash" > container3/container4.sh
echo ssh -t $1 -p $2 /root/container3.sh >> container3/container4.sh

cd container2/ && make build && make start 
cd ../
cd container3/ && make build && make start 
docker network create ssh_network_1
docker network connect ssh_network_1 container2.cont
docker network connect ssh_network_1 container3.cont
