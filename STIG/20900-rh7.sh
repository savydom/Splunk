#!/bin/bash

echo "
STIG 20900

Verify that all system device files are correctly labeled to prevent unauthorized modification.

List all device files on the system that are incorrectly labeled with the following commands:

Note: Device files are normally found under /dev, but applications may place device files in other directories and may necessitate a search of the entire system.

find /dev -context *:device_t:* \( -type c -o -type b \) -printf \"%p %Z\n\" ; find /dev -context *:unlabeled_t:* \( -type c -o -type b \) -printf \"%p %Z\n\"
"

find /dev -context *:device_t:* \( -type c -o -type b \) -printf "%p %Z\n" ; find /dev -context *:unlabeled_t:* \( -type c -o -type b \) -printf "%p %Z\n"

echo "
Note: There are device files, such as \"/dev/vmci\", that are used when the operating system is a host virtual machine. They will not be owned by a user on the system and require the \"device_t\" label to operate. These device files are not a finding.

If there is output from either of these commands, other than already noted, this is a finding.

STIG 20900
"
