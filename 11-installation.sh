#!/bin/bash

# dnf install git -y

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Please run this script with root priveleges"
    exit 1
fi 

dnf install git -y

dnf list installed git

if [ $? -ne 0 ]
then 
    echo "Git is not installed, going to install it..."
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "Git installation is not successful...check it"
        exit 1
    else
        echo "Git installation is successful"
    fi
else    
    echo "Git is already installed, nothing to do..."
fi


dnf list installed mysql

if [ $? -e 0 ]
then 
    echo " Mysql is installed..going to uninstall it"
    dnf remove mysql -y
    if [ $? -ne 0 ]
    then 
        echo "Mysql uninstallation is not successful...check it"
        exit 1
    else    
        echo "Mysql uninstallation is successful.."
    fi
else
    echo "Mysql is already uninstalled..."
fi
