#!/bin/bash

set -e

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(basename "$0" .sh)
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

mkdir -p $LOGS_FOLDER

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

CHECK_ROOT() {
    if [ $USERID -ne 0 ]
    then
        echo -e "$R Please run this script with root privileges $N" | tee -a $LOG_FILE
        exit 1
    fi
}

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is..$R Failed $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 is..$G Success $N" | tee -a $LOG_FILE
    fi
}

USAGE() {
    echo -e "$R USAGE:$N sudo sh 16-redirectors.sh package1 package2"
    exit 1
}

echo "Script started executing at: $(date)" | tee -a $LOG_FILE

CHECK_ROOT

if [ $# -eq 0 ]
then
    USAGE
fi

for package in "$@"
do
    dnf list installed $package &>> $LOG_FILE
    if [ $? -ne 0 ]
    then
        echo -e "$package is $R not installed, going to install it $N" | tee -a $LOG_FILE
        dnf install $package -y &>> $LOG_FILE
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y installed, nothing to do...$N" | tee -a $LOG_FILE
    fi
done
