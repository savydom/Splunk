#!/bin/bash

echo "
STIG 40100

Inspect the firewall configuration and running services to verify that it is configured to prohibit or restrict the use of functions, ports, protocols, and/or services that are unnecessary or prohibited.

Check which services are currently active with the following command:

firewall-cmd --list-all
"

firewall-cmd --list-all

echo "
Ask the System Administrator for the site or program PPSM CLSA. Verify the services allowed by the firewall match the PPSM CLSA. 

If there are additional ports, protocols, or services that are not in the PPSM CLSA, or there are ports, protocols, or services that are prohibited by the PPSM Category Assurance List (CAL), this is a finding.

STIG 40100
"
