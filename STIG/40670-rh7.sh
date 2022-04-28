#!/bin/bash

echo "
STIG 40670

Verify network interfaces are not in promiscuous mode unless approved by the ISSO and documented.

Check for the status with the following command:

ip link | grep -i promisc
"

ip link | grep -i promisc

echo "
If network interfaces are found on the system in promiscuous mode and their use has not been approved by the ISSO and documented, this is a finding.

STIG 40670
"
