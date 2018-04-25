#!/bin/bash

#can change path of benchmark.sh once containers finalized
docker cp benchmark.sh $1:/
docker exec $1 ./benchmark.sh

#input redirect for server? 
