#!/bin/bash

echo "
STIG 10500

 Verify the operating system requires multifactor authentication to uniquely identify organizational users using multifactor authentication.

 Check to see if smartcard authentication is enforced on the system:

grep securid /etc/pam.d/*
"

grep securid /etc/pam.d/*

echo "
If any modules are blank, this is a finding.

STIG 10500
"
