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
