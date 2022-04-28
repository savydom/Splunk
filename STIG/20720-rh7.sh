#!/bin/bash

echo "
STIG 20720

Verify that all local interactive user initialization files' executable search path statements do not contain statements that will reference a working directory other than the users' home directory.

Check the executable search path statement for all local interactive user initialization files in the users' home directory with the following commands:

ls -ld \$(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print \$9}' | while read line;do grep -i path \$line/.[^.]*;done 2>/dev/null
"

ls -ld $(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print $9}' | while read line;do grep -i path $line/.[^.]*;done 2>/dev/null

echo "
If any local interactive user initialization files have executable search path statements that include directories outside of their home directory, this is a finding.

STIG 20720
"
