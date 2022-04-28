#!/bin/bash

echo "
STIG 21040

Verify that the default umask for all interactive users is 077.

Check all local interactive user initialization files for interactive users with the following command:

 Note: The example is for a system that is configured to create users home directories in the /home directory.

grep -i umask /home/*/.* 2>/dev/null
"

grep -i umask /home/*/.* 2>/dev/null

echo "
If any local interactive user initialization files are found to have a umask statement that has a value less restrictive than 077, this is a finding.

STIG 21040
"
