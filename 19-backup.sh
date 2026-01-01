#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USAGE() {
    echo -e "$R USAGE::$N backup <source_dir> <dest_dir> [days]"
}

# Argument validation
if [ $# -lt 2 ]; then
    USAGE
    exit 1
fi

# Source directory check
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "$R ERROR: Source directory does not exist -> $SOURCE_DIR $N"
    exit 1
fi

# Destination directory check (IMPORTANT FIX)
if [ ! -d "$DEST_DIR" ]; then
    echo -e "$Y Destination directory does not exist. Creating it... $N"
    mkdir -p "$DEST_DIR" || exit 1
fi

# Find files once
FILES=$(find "$SOURCE_DIR" -type f -name "*.log" -mtime +"$DAYS")

if [ -n "$FILES" ]; then
    echo -e "$G Files found. Creating backup... $N"

    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"

    echo "$FILES" | zip "$ZIP_FILE" -@

    if [ -f "$ZIP_FILE" ]; then
        echo -e "$G Backup created successfully: $ZIP_FILE $N"

        while IFS= read -r file; do
            echo "Deleting file: $file"
            rm -f "$file"
        done <<< "$FILES"
    else
        echo -e "$R ERROR: Zipping failed $N"
        exit 1
    fi
else
    echo -e "$Y No log files older than $DAYS days $N"
fi
