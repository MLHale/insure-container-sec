#!/bin/bash

#Ensure all tasks are deleted before running
#Target, user, and password have already been established

sleep 300
echo "Chaning admin password"
openvasmd --user=admin --new-password=new_password
sleep 5

echo "Creating target"
omp --xml="<create_target><name>container</name><hosts>127.0.0.1</hosts></create_target>" -u admin -w new_password
sleep 5

#Get Target UUID
echo "Getting target UUID"
TUUID=$(omp -u admin -w new_password -T  | grep container | cut -d ' ' -f1 | tr -d '\n')
sleep 5

# get uuid for "Full and fast" scan
echo "Getting "Full and fast" UUID"
CUUID=$(omp -u admin -w new_password -g | grep "Full and fast" | grep -v "ultimate" | cut -d' ' -f1)
sleep 5

#Create Task -> always use same config UUID, hard coded
echo "Creating task"
omp -u admin -w new_password -C --target=$TUUID -c $CUUID -n "container_scan"
sleep 5

#Find task ID
echo "Getting task id"
TASKID=$(omp -u admin -w new_password -G | grep "container_scan" | cut -d' ' -f1)
sleep 5

#Start Task
echo "Starting task"
omp -u admin -w new_password -S $TASKID
sleep 5

COMPLETE=$(omp -u admin -w new_password --get-tasks | grep container_scan | cut -d' ' -f3)
while  [ "$COMPLETE" != "Done" ]; do
        echo "Scan not complete. Sleeping."
        sleep 30
        COMPLETE=$(omp -u admin -w new_password --get-tasks | grep container_scan | cut -d' ' -f3)
done


echo "Getting report ID"
REPORTID=$(omp -u admin -w new_password --get-tasks --details | sed -n 2p | cut -d ' ' -f3)
sleep 5

#get HTML UUID
echo "Getting HTML UUID Format"
HTMLUUID=$(omp -F -u admin -w new_password | grep HTML | cut -d ' ' -f1)
sleep 5

#Generate Report
echo "Generating Report"
omp -u admin -w new_password -R $REPORTID -f $HTMLUUID > /outputs/report.html
