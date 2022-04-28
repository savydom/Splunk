#!/bin/bash

echo "
STIG 20730
Verify that local initialization files do not execute world-writable programs.

Check the system for world-writable files with the following command:

find / -xdev -perm -002 -type f -exec ls -ld {} \; | awk '{print \$9}' | while read line;do grep \$line \`ls -ld \$(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print \$9}'\`;done 2>/dev/null
"

find / -xdev -perm -002 -type f -exec ls -ld {} \; | awk '{print $9}' | while read line;do grep $line `ls -ld $(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print $9}'`;done 2>/dev/null

echo "
For all files listed, check for their presence in the local initialization files with the following commands:

Note: The example will be for a system that is configured to create users' home directories in the /home directory.

# grep <file> /home/*/.*

If any local initialization files are found to reference world-writable files, this is a finding.

STIG 20730
"
