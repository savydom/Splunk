#!/bin/bash

echo "
STIG 31010

Verify that the system is not accepting rsyslog messages from other systems unless it is documented as a log aggregation server.

Check the configuration of rsyslog with the following command:

grep imtcp /etc/rsyslog.conf ; grep imudp /etc/rsyslog.conf ; grep imrelp /etc/rsyslog.conf
"

grep imtcp /etc/rsyslog.conf ; grep imudp /etc/rsyslog.conf ; grep imrelp /etc/rsyslog.conf

echo "
If any of the above modules are being loaded in the /etc/rsyslog.conf file, ask to see the documentation for the system being used for log aggregation.

If the documentation does not exist, or does not specify the server as a log aggregation system, this is a finding.

STIG 31010
"
