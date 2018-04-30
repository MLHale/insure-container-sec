#!/bin/sh
echo "Waiting to get added to the correct docker network"
sleep 30
nmap -iL /root/host_to_scan.txt -oX /outputs/results.xml.txt
