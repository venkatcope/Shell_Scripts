#!/bin/bash

# Paths to source and destination files
source_file="user_host_list.txt"
destination_file="dest_server"

# Check if files exist
if [[ ! -f $source_file || ! -f $destination_file ]]; then
    echo "Source or destination file not found!"
    exit 1
fi

# Read source file line by line
while read -r source_uid source_ip; do
    echo "Processing connections from Source: $source_uid@$source_ip"

    # Read destination file line by line for each source
    while read -r dest_uid dest_ip; do
        echo "Checking Destination: $dest_uid@$dest_ip from Source: $source_uid@$source_ip"

        # Call the expect script
        ./auto_ssh_hostkey.exp "$source_uid" "$source_ip" "$dest_uid" "$dest_ip"
    done < "$destination_file"

done < "$source_file"
