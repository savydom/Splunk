#!/bin/bash

echo "
STIG ID 40170
"

echo "
Verify any publicly accessible connection to the operating system displays the Standard Mandatory DoD Notice and Consent Banner before granting access to the system.

grep -i banner /etc/ssh/sshd_config

cat /etc/issue
"

grep -i banner /etc/ssh/sshd_config

cat /etc/issue

echo "
If the text in the file does not match the Standard Mandatory DoD Notice and Consent Banner, this is a finding.
"
echo "
STIG ID 40170
"
