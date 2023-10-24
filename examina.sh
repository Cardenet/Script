#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

if [[ ! "$1" =~ ^/ ]]; then
    echo "The path is not absolute."
    exit 1
fi

if [ -e "$1" ]; then
    echo "File exists."
else
    echo "File does not exist."
fi

if [ -r "$1" ]; then
    echo "File is readable."
else
    echo "File is not readable."
fi

if [ -w "$1" ]; then
    echo "File is writable."
else
    echo "File is not writable."
fi

if [ -x "$1" ]; then
    echo "File is executable."
else
    echo "File is not executable."
fi

file_info=$(file "$1")
echo "Output of 'file' command applied to the file:"
echo "$file_info"
