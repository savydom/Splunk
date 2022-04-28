#!/bin/bash

echo "
STIG 21010

Verify file systems that are used for removable media are mounted with the nosuid option.

Check the file systems that are mounted at boot time with the following command:

more /etc/fstab
"

more /etc/fstab

echo "
If a file system found in /etc/fstab refers to removable media and it does not have the nosuid option set, this is a finding.

STIG 21010
"
