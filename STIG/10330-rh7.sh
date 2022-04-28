#!/bin/bash

echo "
STIG 10330

Verify the operating system automatically locks the root account until it is released by an administrator when three unsuccessful logon attempts in 15 minutes are made.

grep pam_faillock.so /etc/pam.d/password-auth ; grep pam_faillock.so /etc/pam.d/system-auth
"

grep pam_faillock.so /etc/pam.d/password-auth ; grep pam_faillock.so /etc/pam.d/system-auth

echo "If the even_deny_root setting is not defined on both lines with the pam_faillock.so module, is commented out, or is missing from a line, this is a finding.

STIG 10330
"
