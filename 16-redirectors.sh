#!/bin/bash

#/var/log/shell-script/16-redirectors-<timestamp>.log

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)

LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

mkdir -p $LOGS_FOLDER

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R Please run this script with root priveleges $N" | tee -a $LOG_FILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is..$R Failed $N" | tee -a $LOG_FILE
        exit 1
    else
        echo "$2 is..$G Success $N" | tee -a $LOG_FILE
    fi
}

USAGE(){
    echo -e "$R USAGE: $N sudo sh 16-redirectors.sh package1 package2"
}

CHECK_ROOT

if [ $# -eq 0 ] #sudo sh 16-redirectors.sh 
then
    USAGE
fi


for package in $@

do
    dnf list installed $package
    if [ $? -ne 0 ]
    then 
        echo "$package is not installed, going to install it"
        dnf install $package -y
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y installed, nothing to do...$N"
    fi
done
