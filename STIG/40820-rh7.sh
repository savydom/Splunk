#!/bin/bash

echo "
STIG 40820

Verify the system does not have unauthorized IP tunnels configured.

Check to see if libreswan is installed with the following command:

yum list installed libreswan
"

yum list installed libreswan

echo "
If libreswan is installed, IPsec is active, and an undocumented tunnel is active, this is a finding.

STIG 40820
"
