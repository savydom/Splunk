#!/bin/bash

echo "
STIG 20260

Verify the operating system security patches and updates are installed and up to date. Updates are required to be applied with a frequency determined by the site or Program Management Office (PMO). 

Obtain the list of available package security updates from Red Hat. The URL for updates is https://rhn.redhat.com/errata/. It is important to note that updates provided by Red Hat may not be present on the system if the underlying packages are not installed.

Check that the available package security updates have been installed on the system with the following command:

yum history list | more
"

yum history list | more


echo "
If package updates have not been performed on the system within the timeframe that the site/program documentation requires, this is a finding. 

Typical update frequency may be overridden by Information Assurance Vulnerability Alert (IAVA) notifications from CYBERCOM.

If the operating system is in non-compliance with the Information Assurance Vulnerability Management (IAVM) process, this is a finding.

STIG 20260
"
