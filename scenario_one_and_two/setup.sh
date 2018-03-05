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
