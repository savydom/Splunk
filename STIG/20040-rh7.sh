#!/bin/bash

echo "
STIG 20040

Verify the operating system notifies designated personnel if baseline configurations are changed in an unauthorized manner.

Note: A file integrity tool other than Advanced Intrusion Detection Environment (AIDE) may be used, but the tool must be executed and notify specified individuals via email or an alert.

Check for the presence of a cron job running routinely on the system that executes AIDE to scan for changes to the system baseline. The commands used in the example will use a daily occurrence.

Check the cron directories for a crontab script file controlling the execution of the file integrity application. For example, if AIDE is installed on the system, use the following command:

ls -al /etc/cron.* | grep aide ; grep aide /etc/crontab /var/spool/cron/root
"

ls -al /etc/cron.* | grep aide ; grep aide /etc/crontab /var/spool/cron/root

echo "
AIDE does not have a configuration that will send a notification, so the cron job uses the mail application on the system to email the results of the file integrity run as in the following example:

# more /etc/cron.daily/aide
#!/bin/bash

/usr/sbin/aide --check | /bin/mail -s \"\$HOSTNAME - Daily aide integrity check run\" root@sysname.mil

Results:

more /etc/cron.daily/aide
"

more /etc/cron.daily/aide

echo "
If the file integrity application does not notify designated personnel of changes, this is a finding.

STIG 20040
"
