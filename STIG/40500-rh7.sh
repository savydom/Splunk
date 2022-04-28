#!/bin/bash

echo "
STIG 40500

Check to see if NTP is running in continuous mode.

systemctl status chronyd
"

systemctl status chronyd ; chronyc sources ; grep iburst /etc/chrony.conf

echo "
If NTP is not running, this is a finding.
"


echo "
STIG 40500
"
