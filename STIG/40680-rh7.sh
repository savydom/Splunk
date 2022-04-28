#!/bin/bash

echo "
STIG 40680

Verify the system is configured to prevent unrestricted mail relaying.

Determine if postfix is installed with the following commands:

yum list installed postfix
"

yum list installed postfix

echo "
If postfix is not installed, this is Not Applicable.

If postfix is installed, determine if it is configured to reject connections from unknown or untrusted networks with the following command:

postconf -n smtpd_client_restrictions 2>/dev/null
"

postconf -n smtpd_client_restrictions 2>/dev/null

echo "
If the smtpd_client_restrictions parameter contains any entries other than permit_mynetworks and reject, this is a finding.

STIG 40680
"
