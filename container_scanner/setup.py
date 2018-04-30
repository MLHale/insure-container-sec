#!/usr/bin/python
import re
import os
import sys
import datetime
import time

valid = ["yes", "y", "no","n"]
yes = ["yes", "y"]

def ubuntu_cis(container_name):
    os.system('chmod 700 ubuntu_cis.sh')
    os.system('docker cp ubuntu_cis.sh {0}:/ubuntu_cis.sh'.format(container_name))
    os.system('docker exec {0} /ubuntu_cis.sh > ./outputs/ubuntu_cis.txt &'.format(container_name))


def docker_cis():
    os.system('chmod 700 docker-bench-security/docker-bench-security.sh')
    os.system('cd docker-bench-security && ./docker-bench-security.sh > ../outputs/docker_cis.txt &')

def cleanup():
    if os.path.isfile('previous_container'):
        previous = open('previous_container').read().strip()
        os.system('docker network disconnect master_default {0}'.format(previous))
    print "Cleaning old files"
    os.system("rm -rf ./outputs/*")
    os.system("docker-compose down")
   # x=str(datetime.datetime.now())
   # os.system("mkdir './outputs/{0}'".format(x))
   # os.system("mv ./outputs/*.txt './outputs/{0}'".format(x))
   # os.system("mv ./outputs/*.html './outputs/{0}'".format(x))
   # os.system("mv ./outputs/*.html {0}".format(x))
    
def get_ipaddr():
    match=None
    while match == None:
        ip_addr=raw_input("What ip address would you like to scan? ")
        match=re.match(r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$",ip_addr)
    return ip_addr

def write_nmap(ip_addr):
    nmap_file = open("nmap/host_to_scan.txt","w")
    nmap_file.write(ip_addr)
    nmap_file.close()

def get_local_scan():
    local_scan=None
    while local_scan not in valid:
        local_scan=raw_input("Are you scanning a local container (yes/no): ").lower()
    if local_scan in yes:
        return True
    else:
        return False

def get_container_name():
    line_count=0
    while line_count == 0:
        container_name=raw_input("What is the name of the container you want to scan? ")
        command='docker ps -f "name={0}" | grep -w {0} | wc -l'.format(container_name)
        line_count=int(os.popen(command).read().strip()) 
    return container_name

def get_ubuntu_container():
    ubuntu=None
    while ubuntu not in valid:
        ubuntu=raw_input("Are you scanning an Ubuntu container (yes/no): ").lower()
    if ubuntu in yes:
        return True
    else: 
        return False

def do_openvas(name):
    container_name=os.popen('docker ps -f "name=master_openvas" --format "{{.Names}}"').read().strip()
    os.system('chmod 700 openvas.sh')
    os.system('docker cp openvas.sh {0}:/openvas.sh'.format(container_name))
    os.system('docker exec {0} /openvas.sh {1} &'.format(container_name, name))

def start_docker():
    os.system("docker-compose up -d --build")
    time.sleep(10)

cleanup()
local_scan=get_local_scan()
if local_scan:
    container_name=get_container_name()
    ubuntu=get_ubuntu_container()
    write_nmap(container_name)
else:
    ip_addr=get_ip_addr()
    write_nmap(ip_addr)

start_docker()
os.system("docker network connect master_default {0}".format(container_name))
open('previous_container','w').write(container_name)
if local_scan:
    docker_cis()
    if ubuntu: 
        ubuntu_cis(container_name)
    do_openvas(container_name)
else:
    do_openvas(ip_addr)
