#!/bin/bash

a=`cat /etc/redhat-release | tr -d [:alpha:] | tr -d [:punct:] | while read line;do echo $line | cut -c1;done`

echo "#!/bin/bash" > combine-NR-results-rh$a.sh
echo "src=/usr/local/etc/stig/scripts" >> combine-NR-results-rh$a.sh
echo "host=\`hostname -s\`" >> combine-NR-results-rh$a.sh
echo "date=\`date +%Y%m%d\`" >> combine-NR-results-rh$a.sh

ls | grep ^[1-9] | grep rh | cut -d "-" -f 1 | while read line;do echo "cat \$src/$line.results >> \${host}-\${date}.results";done >> combine-NR-results-rh$a.sh
