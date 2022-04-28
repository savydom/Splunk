#!/bin/bash

echo "
STIG 40310

Verify SSH is loaded and active with the following command:

systemctl status sshd
"

systemctl status sshd

echo "
If sshd does not show a status of active and running, this is a finding.

STIG 40310
"
