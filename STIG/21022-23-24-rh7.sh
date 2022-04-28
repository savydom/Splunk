#!/bin/bash

echo "
STIG 21022, 21023, 21024

Verify that the nodev option is configured for /dev/shm:

cat /etc/fstab | grep /dev/shm
"

cat /etc/fstab | grep /dev/shm

echo "
Verify /dev/shm is mounted with the nodev, nosuid, and noexec options:

mount | grep \"/dev/shm\" | grep nodev ; mount | grep \"/dev/shm\" | grep noexec ; mount | grep \"/dev/shm\" | grep nosuid
"

mount | grep "/dev/shm" | grep nodev ; mount | grep "/dev/shm" | grep noexec ; mount | grep "/dev/shm" | grep nosuid

echo "
If no results are returned, this is a finding.

STIG 21022, 21023, 21024
"
