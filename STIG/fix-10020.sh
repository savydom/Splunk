#!/bin/bash

rpm -Va --noconfig | grep '^..5' | awk '{print $NF}' | while read line;do rpm -qf $line;done > /usr/local/etc/stig/scripts/tmp-10020

cat /usr/local/etc/stig/scripts/tmp-10020 | sort | uniq > fix-10020.results

rm -f tmp-10020

echo "
~~~~~~~~~~~~~~~~STIG ID 10020 CYPTOGRAPHIC HASH MISMATCH~~~~~~~~~~~~~~~~~~~~~~~
"

cat fix-10020.results

echo "
~~~~~~~~~~~~~~~STIG ID 10020 CYPTOGRAPHIC HASH MISMATCH~~~~~~~~~~~~~~~~~~~~~~~
"

echo "
Uncomment the last line in the script if you have determined a reinstall of software is appropriate to return cryptographic hashes to vendor defaults.
"

#cat fix-10020.results | while read line;do yum reinstall $line -y;done

echo "
Please run the OpenSCAP scan again and verify the cryptographic hashes for software matches default vendor values.
"
