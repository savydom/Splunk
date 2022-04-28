#!/bin/bash

echo "
STIG 21000

Verify file systems that contain user home directories are mounted with the nosuid option.

Find the file system(s) that contain the user home directories with the following command:

Note: If a separate file system has not been created for the user home directories (user home directories are mounted under /), this is not a finding as the nosuid option cannot be used on the / system.

grep \`ls -ld \$(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print \$9}'\` /etc/fstab 2&>/dev/null
"

grep `ls -ld $(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6) | awk '{print $9}'` /etc/fstab 2&>/dev/null

echo "
If a file system found in /etc/fstab refers to the user home directory file system and it does not have the nosuid option set, this is a finding.

STIG 21000
"
