#!/bin/bash

echo "
STIG 10320

Check that the system locks an account for a minimum of 15 minutes after three unsuccessful logon attempts within a period of 15 minutes with the following command:

grep pam_faillock.so /etc/pam.d/password-auth ; grep pam_faillock.so /etc/pam.d/system-auth

"

grep pam_faillock.so /etc/pam.d/password-auth ; grep pam_faillock.so /etc/pam.d/system-auth

echo "
If the deny parameter is set to 0 or a value less than 3 on both auth lines with the pam_faillock.so module, or is missing from these lines, this is a finding.

If the even_deny_root parameter is not set on both auth lines with the pam_faillock.so module, or is missing from these lines, this is a finding.

If the fail_interval parameter is set to 0 or is set to a value less than 900 on both auth lines with the pam_faillock.so module, or is missing from these lines, this is a finding.

If the unlock_time parameter is not set to 0, never, or is set to a value less than 900 on both auth lines with the pam_faillock.so module or is missing from these lines, this is a finding.

Note: The maximum configurable value for unlock_time is 604800. 

If any line referencing the pam_faillock.so module is commented out, this is a finding.

STIG 10320
"
