#!/bin/bash

echo "
STIG 21300

 Verify that kernel core dumps are disabled unless needed.

 Check the status of the kdump service with the following command:

systemctl status kdump.service 
 "

systemctl status kdump.service

echo "
If the kdump service is active, ask the System Administrator if the use of the service is required and documented with the Information System Security Officer (ISSO).

If the service is active and is not documented, this is a finding.

STIG 21300
"
