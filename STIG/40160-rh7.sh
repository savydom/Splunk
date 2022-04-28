#!/bin/bash

echo "
STIG 40160

Verify the operating system terminates all network connections associated with a communications session at the end of the session or based on inactivity.

Check the value of the system inactivity timeout with the following command:

grep -i tmout /etc/profile.d/*
"

grep -i tmout /etc/profile.d/*

echo "
If TMOUT is not set to 600 or less in a script located in the /etc/profile.d/ directory to enforce session termination after inactivity, this is a finding.

STIG 40160
"
