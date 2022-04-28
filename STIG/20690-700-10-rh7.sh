#!/bin/bash

echo "
STIG 20690 20700 20710

Verify the local initialization files of all local interactive users are group-owned by that user's primary Group Identifier (GID).

Check the home directory assignment for all non-privileged users on the system with the following command:

ls -ld \$(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print \$9}' | while read line;do ls -al \$line/.[^.]*;done
"

ls -ld $(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print $9}' | while read line;do ls -al $line/.[^.]*;done

echo "
If all local interactive user's initialization files are not group-owned by that user's primary GID, this is a finding.

STIG 20690 20700 20710
"
