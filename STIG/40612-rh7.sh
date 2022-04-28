#!/bin/bash

echo "
STIG 40612

Verify the system uses a reverse-path filter for IPv4:

grep net.ipv4.conf.default.rp_filter /etc/sysctl.conf /etc/sysctl.d/*
"

grep net.ipv4.conf.default.rp_filter /etc/sysctl.conf /etc/sysctl.d/*

echo "
If net.ipv4.conf.default.rp_filter is not configured in the /etc/sysctl.conf file or in the /etc/sysctl.d/ directory, is commented out, or does not have a value of 1, this is a finding.

Check that the operating system implements the accept source route variable with the following command:

/sbin/sysctl -a | grep net.ipv4.conf.default.rp_filter
"

/sbin/sysctl -a | grep net.ipv4.conf.default.rp_filter

echo "
If the returned line does not have a value of 1, this is a finding.

STIG 40612
"
