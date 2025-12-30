#!/bin/bash

NUMBER1=$1
#NUMBER2=$2

echo "Enter the NUMBER2 value:"
read -s NUMBER2

SUM=$(($NUMBER1 + $NUMBER2))

echo "Total of $NUMBER1 and $NUMBER2 is: $SUM"