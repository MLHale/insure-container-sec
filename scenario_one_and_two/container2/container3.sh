#!/bin/bash
scp /root/testfile root@container3.cont:/root/testfile
ssh -t root@container3.cont
