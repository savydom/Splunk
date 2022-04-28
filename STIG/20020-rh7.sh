#!/bin/bash

echo "
STIG 20020
"

echo "
Note: Per OPORD 16-0080, the preferred intrusion detection system is McAfee Host Intrusion Prevention System (HIPS) in conjunction with SELinux. McAfee Endpoint Security for Linux (ENSL) is an approved alternative to McAfee Virus Scan Enterprise (VSE) and HIPS. For RHEL 7 systems, SELinux is an approved alternative to McAfee HIPS. Regardless of whether or not McAfee HIPS or ENSL is installed, SELinux is interoperable with both McAfee products and SELinux is still required.

Verify the operating system prevents non-privileged users from executing privileged functions to include disabling, circumventing, or altering implemented security safeguards/countermeasures.

Get a list of authorized users (other than System Administrator and guest accounts) for the system.

Check the list against the system by using the following command:

semanage login -l | more
"

semanage login -l | more

echo "
All administrators must be mapped to the \"sysadm_u\", \"staff_u\", or an appropriately tailored confined role as defined by the organization.

All authorized non-administrative users must be mapped to the \"user_u\" role. 

If they are not mapped in this way, this is a finding.
"

echo "
STIG 20020
"
