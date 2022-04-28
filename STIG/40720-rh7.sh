#!/bin/bash

echo "
STIG 40720

Verify the TFTP daemon is configured to operate in secure mode.

Check to see if a TFTP server has been installed with the following commands:

yum list installed tftp-server
"

yum list installed tftp-server

echo "
If a TFTP server is not installed, this is Not Applicable.

If a TFTP server is installed, check for the server arguments with the following command:

grep server_args /etc/xinted.d/tftp 2>/dev/null
" 

grep server_args /etc/xinetd.d/tftp 2>/dev/null

echo "
If the server_args line does not have a -s option and a subdirectory is not assigned, this is a finding.

STIG 40720
"
