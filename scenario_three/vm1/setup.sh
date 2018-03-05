#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: ./setup.sh [ip of remote vm] [port going to ssh on remote vm]"
fi

echo "#!/bin/bash" > container1/container2.sh
echo ssh -t $1 -p $2 /root/container3.sh >> container1/container2.sh

cd container1/ && make build && make start
