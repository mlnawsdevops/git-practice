#!/bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

DISK_USAGE=$(df -hT | grep -i "xfs")
DISK_THRESHOLD=5

while IFS= read -r line
do
    USAGE=$(echo $line | grep "xfs" | awk -F " " '{print $6F}' | cut -d "%" -f1) # percentage of disk 

    PARTITION=$(echo $line | grep "xfs" | awk -F " " '{print $NF}') # N means name of the disk
    
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        echo -e "$PARTITION is more than $DISK_THRESHOLD, Current value: $USAGE. $R Please check. $N"
    else
        echo -e "$PARTITION is less than $DISK_THRESHOLD, Current value: $USAGE. $Y Nothing to do.$N"
    fi

done <<< $DISK_USAGE