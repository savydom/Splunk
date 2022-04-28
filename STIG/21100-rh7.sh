#!/bin/bash

echo "
STIG 21100

Verify that rsyslog is configured to log cron events.

grep cron /etc/rsyslog.conf /etc/rsyslog.d/*.conf
"

grep cron /etc/rsyslog.conf /etc/rsyslog.d/*.conf

echo "
If rsyslog is not logging messages for the cron facility or all facilities, this is a finding.

STIG 21100
"
