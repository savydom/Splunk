#!/bin/bash

echo "
STIG 40180, 40190, 40200

Determine the id_provider the LDAP is currently using:

grep -i \"id_provider\" /etc/sssd/sssd.conf
"

grep -i "id_provider" /etc/sssd/sssd.conf

echo "
If id_provider is set to ad, this is Not Applicable.

STIG 40180, 40190, 40200
"
