#!/bin/sh
nmap -iL hosts_to_scan.txt -oX /outputs/results.xml.txt
