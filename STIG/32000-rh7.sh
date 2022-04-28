#!/bin/bash

echo "
STIG 32000

Verify an anti-virus solution is installed on the system. The anti-virus solution may be bundled with an approved host-based security solution.

rpm -qa | grep MFE*
"

rpm -qa | grep MFE*

echo "
If there is no anti-virus solution installed on the system, this is a finding.

STIG 32000
"
