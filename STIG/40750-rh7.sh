#!/bin/bash

echo "
STIG 40750

Verify AUTH_GSS is being used to authenticate NFS mounts.

To check if the system is importing an NFS file system, look for any entries in the /etc/fstab file that have a file system type of nfs with the following command:

cat /etc/fstab | grep nfs
"

cat /etc/fstab | grep nfs

echo "
If the system is mounting file systems via NFS and has the sec option without the krb5:krb5i:krb5p settings, the sec option has the sys setting, or the sec option is missing, this is a finding.

STIG 40750
"
