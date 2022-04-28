#!/bin/bash

echo "
STIG 20660 20670 20680

Verify all files and directories in a local interactive user's home directory are owned by the user.

Check the owner of all files and directories in a local interactive user's home directory with the following command:

ls -ld \$(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print \$9}' | while read line;do ls -lLR $line;done
"

ls -ld $(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print $9}' | while read line;do ls -lLR $line;done

echo "
If any files are found with an owner different than the home directory user, this is a finding.

STIG 20660 20670 20680
"
