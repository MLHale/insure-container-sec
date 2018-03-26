cd container2/ && make build && make start
cd ../
cd container3/ && make build && make start
docker network create ssh_network_1
docker network connect ssh_network_1 container2.cont
docker network connect ssh_network_1 container3.cont
