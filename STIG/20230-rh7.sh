#!/bin/bash

echo "
STIG 20230

Verify the operating system is not configured to reboot the system when Ctrl-Alt-Delete is pressed.

Check that the ctrl-alt-del.target is masked and not active with the following command:

systemctl status ctrl-alt-del.target
"

systemctl status ctrl-alt-del.target

echo "
If the ctrl-alt-del.target is not masked, this is a finding.

If the ctrl-alt-del.target is active, this is a finding.

STIG 20230
"
