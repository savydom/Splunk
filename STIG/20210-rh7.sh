#!/bin/bash

echo "
STIG 20210
"

echo " 
Per OPORD 16-0080, the preferred intrusion detection system is McAfee Host Intrusion Prevention System (HIPS) in conjunction with SELinux. McAfee Endpoint Security for Linux (ENSL) is an approved alternative to McAfee Virus Scan Enterprise (VSE) and HIPS. For RHEL 7 systems, SELinux is an approved alternative to McAfee HIPS. Regardless of whether or not McAfee HIPS or ENSL is installed, SELinux is interoperable with both McAfee products and SELinux is still required.

Verify the operating system verifies correct operation of all security functions.

Check if SELinux is active and in Enforcing mode with the following command:

getenforce
"

getenforce

echo "
If SELinux is not active and not in Enforcing mode, this is a finding.
"

echo "
STIG 20210
"
