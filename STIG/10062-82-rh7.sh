#!/bin/bash

echo "
STIG 10062 10082

Verify the operating system prevents a user from overriding the screensaver lock-enabled setting for the graphical user interface. 

systemctl status graphical.target
"

systemctl status graphical.target

echo "
If the system does not have GNOME installed, this requirement is Not Applicable.

STIG 10062 10082
"
