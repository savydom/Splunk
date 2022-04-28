#!/bin/bash

echo "
STIG 41010

Verify that there are no wireless interfaces configured on the system.

This is N/A for systems that do not have wireless network adapters.

Check for the presence of active wireless interfaces with the following command:

nmcli device
"

nmcli device

echo "
If a wireless interface is configured and its use on the system is not documented with the Information System Security Officer (ISSO), this is a finding.

STIG 41010
"
