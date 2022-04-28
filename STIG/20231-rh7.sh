#!/bin/bash

echo "
STIG 20231

If the operating system does not have a graphical user interface installed, this requirement is Not Applicable.

systemctl status graphical.target
"

systemctl status graphical.target

echo "
Verify the operating system is not configured to reboot the system when Ctrl-Alt-Delete is pressed.

STIG 20231
"
