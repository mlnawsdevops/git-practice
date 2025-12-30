#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R Please run this script with root priveleges $N"
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 is...$R Failed $N"
    else
        echo -e "$2 is...$G Success $N"
    fi
}

CHECK_ROOT

dnf list installed git

if [ $? -ne 0 ]
then   
    echo -e "$R Git is not installed, going to install it... $N"
    dnf install git -y
    VALIDATE $? "Installing Git"
else
    echo -e "$G Git is already installed, nothing to do...$N"
fi


dnf list installed mysqllll

if [ $? -ne 0 ]
then
    echo -e "$R Mysql is not installed, going to install it $N"
    dnf install mysqllll -y
    VALIDATE $? "Installing MYSQL"
else
    echo -e "$G MYSQL is already installed, nothing to do...$N"
fi