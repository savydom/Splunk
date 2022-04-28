#!/bin/bash

echo "
STIG ID 21030
"

echo "
The following command will discover and print world-writable directories that are not group-owned by a system account, assuming only system accounts have a GID lower than 1000. Run it once for each local partition [PART]: 

find [PART] -xdev -type d -perm -0002 -gid +999 -print

If there is output, this is a finding.
"

mount | awk '{print $3}' | while read line;do find $line -xdev -type d -perm -0002 -gid +999 -print | while read line;do ls -al $line | grep s;done;done

echo "
STIG ID 21030
"
