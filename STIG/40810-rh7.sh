#!/bin/bash

echo "
STIG 40810

If the firewalld package is not installed, ask the System Administrator (SA) if another firewall application (such as iptables) is installed. If an application firewall is not installed, this is a finding. 

Verify the system's access control program is configured to grant or deny system access to specific hosts.

Check to see if firewalld is active with the following command:

systemctl status firewalld
"

systemctl status firewalld

echo "
If firewalld is active, check to see if it is configured to grant or deny access to specific hosts or services with the following commands:

firewall-cmd --get-default-zone ; firewall-cmd --list-all --zone=public
"

firewall-cmd --get-default-zone ; firewall-cmd --list-all --zone=public

echo "
If firewalld is not active, determine whether tcpwrappers is being used by checking whether the hosts.allow and hosts.deny files are empty with the following commands:

ls -al /etc/hosts.allow ; ls -al /etc/hosts.deny
"

ls -al /etc/hosts.allow ; ls -al /etc/hosts.deny

echo "
If firewalld and tcpwrappers are not installed, configured, and active, ask the SA if another access control program (such as iptables) is installed and active. Ask the SA to show that the running configuration grants or denies access to specific hosts or services.

If firewalld is active and is not configured to grant access to specific hosts or tcpwrappers is not configured to grant or deny access to specific hosts, this is a finding.

STIG 40810
"
