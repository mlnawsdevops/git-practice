#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if $3 is empty, default is 14days
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

USAGE(){
    echo -e "$R USAGE::$N sh 19-backup.sh source destination days"
}

if [ $# -lt 2 ]
then    
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then 
    echo "$SOURCE_DIR does not exist...Please check"
fi

if [ ! -d $DEST_DIR ]
then
    echo "$DEST_DIR does not exist...Please check"
fi

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +${DAYS})
echo "Files: $FILES"

if [ ! -z $FILES ] #true if files are empty, ! makes it expression false
then
    echo "Files are found"
    ZIP_FILES="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find ${SOURCE_DIR} -name "*.log" -mtime +$DAYS | zip "$ZIP_FILES" -@

    #check if zip is successfully created or not

    if [ -f $ZIP_FILES ]
    then
        echo "successfully zipped files older than $DAYS"

        while ISP= read -r file
        do
            echo "deleting file: $file"
            rm -rf $file
        done <<< $ZIP_FILES

    else
        echo "Zipping the files are failed"
        exit 1
    fi
    
else
    echo "No files older than $DAYS"
fi