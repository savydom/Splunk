#!/bin/bash

echo "
STIG 20019

Ask the SA or ISSO if a host-based intrusion detection application is loaded on the system. Per OPORD 16-0080, the preferred intrusion detection system is McAfee HBSS available through the U.S. Cyber Command (USCYBERCOM).

If another host-based intrusion detection application is in use, such as SELinux, this must be documented and approved by the local Authorizing Official.

Procedure:
Examine the system to determine if the Host Intrusion Prevention System (HIPS) is installed:

rpm -qa | grep MFE*
"

rpm -qa | grep MFE*

echo "
Verify that the McAfee HIPS module is active on the system:

ps -ef | grep McAfee
"

ps -ef | grep McAfee

echo "
If the MFEhiplsm package is not installed and an alternate host-based intrusion detection application has not been documented for use, this is a finding.

If no host-based intrusion detection system is installed and running on the system, this is afinding.

STIG 20019
"
