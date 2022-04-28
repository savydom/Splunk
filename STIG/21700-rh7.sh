#!/bin/bash

echo "
STIG 21700

Verify the system is not configured to use a boot loader on removable media.

Note: GRUB 2 reads its configuration from the /boot/grub2/grub.cfg file on traditional BIOS-based machines and from the /boot/efi/EFI/redhat/grub.cfg file on UEFI machines.

Check for the existence of alternate boot loader configuration files with the following command:

find / -name grub.cfg 2>/dev/null
"

find / -name grub.cfg 2>/dev/null

echo "
If a grub.cfg is found in any subdirectories other than /boot/grub2 and /boot/efi/EFI/redhat, ask the System Administrator if there is documentation signed by the ISSO to approve the use of removable media as a boot loader. 

Check that the grub configuration file has the set root command in each menu entry with the following commands:

grep -c menuentry /boot/grub2/grub.cfg ; grep 'set root' /boot/grub2/grub.cfg
"

grep -c menuentry /boot/grub2/grub.cfg ; grep 'set root' /boot/grub2/grub.cfg

echo "
If the system is using an alternate boot loader on removable media, and documentation does not exist approving the alternate configuration, this is a finding.

STIG 21700
"
