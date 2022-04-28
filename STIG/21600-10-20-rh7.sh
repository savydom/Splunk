#!/bin/bash

echo "
STIG 21600, 21610, 21620

If AIDE is not installed, ask the System Administrator how file integrity checks are performed on the system. 

Check the aide.conf file to determine if the acl rule has been added to the rule list being applied to the files and directories selection lists.

An example rule that includes the acl rule is below:

All= p+i+n+u+g+s+m+S+sha512+acl+xattrs+selinux
/bin All # apply the custom rule to the files in bin 
/sbin All # apply the same custom rule to the files in sbin 

grep acl /etc/aide.conf
"

grep acl /etc/aide.conf


echo "
If the acl rule is not being used on all uncommented selection lines in the /etc/aide.conf file, or ACLs are not being checked by another file integrity tool, this is a finding.

STIG 21600, 21610, 21620
"
