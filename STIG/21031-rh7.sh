#!/bin/bash

echo "
STIG ID 21031
"

echo "
The following command will discover and print world-writable directories that are not group-owned by a system account, assuming only system accounts have a GID lower than 1000.
"

mount | awk '{print $3}' | while read line;do find $line -xdev -type d -perm -0002 -uid +999 -print | while read line;do ls -al $line;done;done

echo "
If there is output, this is a finding.
"

echo "
STIG ID 21031
"
