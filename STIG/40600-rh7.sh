#!/bin/bash

echo "
STIG 40600

Determine whether the system is using local or DNS name resolution with the following command:

grep hosts /etc/nsswitch.conf
"

grep hosts /etc/nsswitch.conf

echo "
If the DNS entry is missing from the host's line in the /etc/nsswitch.conf file, the /etc/resolv.conf file must be empty.

If the DNS entry is found on the host's line of the /etc/nsswitch.conf file, verify the operating system is configured to use two or more name servers for DNS resolution.

Determine the name servers used by the system with the following command:

grep nameserver /etc/resolv.conf
"

grep nameserver /etc/resolv.conf

echo "
If less than two lines are returned that are not commented out, this is a finding.

Verify that the /etc/resolv.conf file is immutable with the following command:

lsattr /etc/resolv.conf
(example)
----i----------- /etc/resolv.conf
"

lsattr /etc/resolv.conf

echo "
If the file is mutable and has not been documented with the Information System Security Officer (ISSO), this is a finding.

STIG 40600
"
