#!/bin/bash

echo "
STIG ID 910055
"

echo "
Verify the operating system audit records have proper permissions and ownership.

ls -la /var/log/audit 
"

ls -la /var/log/audit

echo "
Audit logs must be mode 0600 or less permissive. 
If any are more permissive, this is a finding.
"

echo "
STIG ID 910055
"
