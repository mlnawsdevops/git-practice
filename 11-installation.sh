#!/bin/bash

# dnf install git -y

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Please run this script with root priveleges"
    exit 1
fi 

dnf install git -y

dnf list installed gittt

if [ $? -ne 0 ]
then 
    echo "Git is not installed, going to install it..."
    dnf install gittt -y
    if [ $? -ne 0 ]
    then
        echo "Git installation is not success...check it"
        exit 1
    else
        echo "Git installation is successful"
    fi
else    
    echo "Git is already installed, nothing to do..."
fi
