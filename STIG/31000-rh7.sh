#!/bin/bash

echo "
STIG 31000

Verify rsyslog is configured to send all messages to a log aggregation server.

Check the configuration of rsyslog with the following command:

Note: If another logging package is used, substitute the utility configuration file for /etc/rsyslog.conf.

grep @ /etc/rsyslog.conf /etc/rsyslog.d/*.conf
"

grep @ /etc/rsyslog.conf /etc/rsyslog.d/*.conf


echo "
If there are no lines in the /etc/rsyslog.conf or /etc/rsyslog.d/*.conf files that contain the @ or @@ symbol(s), and the lines with the correct symbol(s) to send output to another system do not cover all rsyslog output, ask the System Administrator to indicate how the audit logs are off-loaded to a different system or media. 

If the lines are commented out or there is no evidence that the audit logs are being sent to another system, this is a finding.

STIG 31000
"
