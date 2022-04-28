#!/bin/bash

echo "
STIG 20111

Verify the operating system disables the ability to automount devices in a graphical user interface.

systemctl status graphical.target
"

systemctl status graphical.target

echo "

If there is no GUI, this is not a finding.

STIG 20111
"
