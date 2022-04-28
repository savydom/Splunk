#!/bin/bash

echo "
STIG 20220
"

echo "
Per OPORD 16-0080, the preferred intrusion detection system is McAfee Host Intrusion Prevention System (HIPS) in conjunction with SELinux. McAfee Endpoint Security for Linux (ENSL) is an approved alternative to McAfee Virus Scan Enterprise (VSE) and HIPS. For RHEL 7 systems, SELinux is an approved alternative to McAfee HIPS. Regardless of whether or not McAfee HIPS or ENSL is installed, SELinux is interoperable with both McAfee products and SELinux is still required.

Verify the operating system verifies correct operation of all security functions.

Check if SELinux is active and is enforcing the targeted policy with the following command:

sestatus
"

sestatus

echo "
If the \"Loaded policy name\" is not set to \"targeted\", this is a finding.

Verify that the /etc/selinux/config file is configured to the \"SELINUXTYPE\" to \"targeted\":

grep -i \"selinuxtype\" /etc/selinux/config | grep -v '^#'
"

grep -i "selinuxtype" /etc/selinux/config | grep -v '^#'

echo "
If no results are returned or \"SELINUXTYPE\" is not set to \"targeted\", this is a finding.
"

echo "
STIG 20220
"
