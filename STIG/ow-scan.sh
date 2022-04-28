#!/bin/bash

a=`cat /etc/redhat-release | tr -d [:alpha:] | tr -d [:punct:] | while read line;do echo $line | cut -c1;done`

echo "#!/bin/bash" > scan-NR-rh$a.sh
echo "src=/usr/local/etc/stig/scripts" >> scan-NR-rh$a.sh

ls | grep ^[1-9] | grep rh | while read line;do echo "cat \$src/$line > `ls $line | grep ^[1-9] | grep rh | cut -d "-" -f 1`.results";done >> scan-NR-rh$a.sh
