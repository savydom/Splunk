#!/bin/bash

echo "
STIG 30330

Verify the operating system initiates an action to notify the SA and ISSO (at a minimum) when allocated audit record storage volume reaches 75 percent of the repository maximum audit record storage capacity.

Determine what the threshold is for the system to take action when 75 percent of the repository maximum audit record storage capacity is reached:

python -c \"print(\`grep -iw space_left /etc/audit/auditd.conf | awk '/^[^#]/{print \$3}'\`.0/\`df -m /var/log/audit | awk '{print \$4}' | grep '^[0-9]'\`.0)\"
"

python -c "print(`grep -iw space_left /etc/audit/auditd.conf | awk '/^[^#]/{print $3}'`.0/`df -m /var/log/audit | awk '{print $4}' | grep '^[0-9]'`.0)"

echo "
If the value of the space_left keyword is not set to 25 percent of the total partition size, this is a finding.

STIG 30330
"
