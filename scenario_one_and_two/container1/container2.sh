#!/bin/bash
scp /root/testfile root@container2.cont:/root/testfile
ssh -t root@container2.cont /root/container3.sh
