#!/bin/bash

echo "
STIG 20630 20640 20650

Verify the assigned home directory of all local interactive users has a mode of \"0750\" or less permissive.

Check the home directory assignment for all non-privileged users on the system with the following command:

Note: This may miss interactive users that have been assigned a privileged User Identifier (UID). Evidence of interactive use may be obtained from a number of log files containing system logon information.

ls -ld \$(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6)
"

ls -ld $(egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6)

echo "
If home directories referenced in /etc/passwd do not have a mode of 0750 or less permissive, this is a finding.

STIG 20630 20640 20650
"
