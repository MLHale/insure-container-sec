#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: ./setup.sh [ip of second vm running on same hypervisor] [port on vm that forwards to ssh service on container ]"
fi


echo Host container3.cont > container1/config
echo "  User          root" >> container1/config
echo "  HostName      container3.cont" >> container1/config
echo "  ProxyCommand  ssh root@$1 -p $2 nc %h %p 2> /dev/null" >> container1/config

cd container1/ && make build && make start
