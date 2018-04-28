#!/bin/bash

#Ensure all tasks are deleted before running
#Target, user, and password have already been established

#Get Target UUID
TUUID=$(omp -u admin -w new_password -T  | grep test123 | cut -d ' ' -f1 | tr -d '\n')

#Create Task -> always use same config UUID, hard coded
omp -u admin -w new_password -C --target=$TUUID -c daba56c8-73ec-11df-a475-002264764cea -n "new_scan"

#Find task ID
TASKID=$(omp -u admin -w new_password -G | grep "new_scan" | cut -d ' ' -f1)

#Start Task
T=$(omp -u admin -w new_password -S $TASKID)

T2=$(omp -u admin -w new_password --get-tasks --details | sed -n 2p | cut -d ' ' -f3)

#get HTML UUID
RUUID=$(omp -F -u admin -w new_password | grep HTML | cut -d ' ' -f1)

#Generate Report
omp -u admin -w new_password -R $T2 -f $RUUID
