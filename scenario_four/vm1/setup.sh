#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: ./setup.sh [ip of second vm running on same hypervisor] [port on vm that forwards to ssh service on container ]"
fi

echo "#!/bin/bash" > container1/container2.sh
echo ssh -t $1 -p $2 /root/container3.sh >> container1/container2.sh

cd container1/ && make build && make start
