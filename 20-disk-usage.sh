#!/bin/bash

DISK_USAGE=$(df -hT | grep -i "xfs")
DISK_THRESHOLD=5

while IFS= read -r line
do
    USAGE=$(echo $line | grep "xfs" | awk -F " " '{print $6F}' | cut -d "%" -f1) # percentage of disk 

    PARTITION=$(echo $line | grep "xfs" | awk -F " " '{print $NF}') # N means name of the disk
    
    if[ $USAGE -ge $DISK_THRESHOLD ]
    then
        echo "$PARTITION is more than $DISK_THRESHOLD, Current value: $USAGE. Please check"
    else
        echo "$PARTITION is less than $DISK_THRESHOLD, Current value: $USAGE. Nothing to do"
    fi

done <<< $DISK_USAGE