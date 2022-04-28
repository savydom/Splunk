#!/bin/bash

echo "
STIG 40520

Verify the operating system enabled an application firewall.

Check to see if firewalld is installed with the following command:

yum list installed firewalld
"

yum list installed firewalld

echo "
If the firewalld package is not installed, ask the System Administrator if another firewall application (such as iptables) is installed. 

If an application firewall is not installed, this is a finding. 

Check to see if the firewall is loaded and active with the following command:

systemctl status firewalld
"

systemctl status firewalld

echo "
If firewalld does not show a status of loaded and active, this is a finding. 

Check the state of the firewall:

firewall-cmd --state
"

firewall-cmd --state 

echo "
If firewalld does not show a state of running, this is a finding.

STIG 40520
"
