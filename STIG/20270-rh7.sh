#!/bin/bash

echo "
STIG 20270

Verify all accounts on the system are assigned to an active system, application, or user account.

Obtain the list of authorized system accounts from the Information System Security Officer (ISSO).

Check the system accounts on the system with the following command:

more /etc/passwd
"

more /etc/passwd

echo "
Accounts such as games and gopher are not authorized accounts as they do not support authorized system functions. 

If the accounts on the system do not match the provided documentation, or accounts that do not support an authorized system function are present, this is a finding.

STIG 20270
"
