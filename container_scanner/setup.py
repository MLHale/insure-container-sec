#!/usr/bin/python

import re
import os
import sys

config_file = open("config","w")
nmap_file = open("nmap/host_to_scan.txt","w")
match=None
while match == None:
    ip_addr=raw_input("What ip address would you like to scan? ")
    match=re.match(r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$",ip_addr)

nmap_file.write(ip_addr)
nmap_file.close()
 
local_scan=None
valid = ["yes", "y", "no","n"]
yes = ["yes", "y"]
while local_scan not in valid:
    local_scan=raw_input("Are you scanning a local container (yes/no): ").lower()

if local_scan in yes:
    local_scan=True
else:
    local_scan=False

config_file.write("ip_addr=" + ip_addr + "\n")
config_file.write("local_container=" + str(local_scan) + "\n")

if local_scan == False:
    sys.exit()

line_count=0
ubuntu=None
while line_count == 0:
    container_name=raw_input("What is the name of the container you want to scan? ")
    command='docker ps -f "name={0}" | grep -w {0} | wc -l'.format(container_name)
    line_count=int(os.popen(command).read().strip())
while ubuntu not in valid:
    ubuntu=raw_input("Are you scanning an Ubuntu container (yes/no): ").lower()

if ubuntu in yes:
    ubuntu=True
else:
    ubuntu=False

config_file.write("container_name=" + container_name + "\n")
config_file.write("ubuntu=" + str(ubuntu) + "\n")
