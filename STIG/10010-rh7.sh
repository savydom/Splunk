#!/bin/bash

echo "
STIG 10010

Check the default file permissions, ownership, and group membership of system files and commands with the following command:

for i in \`rpm -Va | egrep -i \'^[M|U|G|.]{8}\' | cut -d \" \" -f4,5\`
do
  for j in \`rpm -qf \$i\`
  do
    rpm -ql \$j --dump | cut -d \" \" -f1,5,6,7 |  grep \$i
  done
done > 10010-1.results

rpm -Va | egrep -i '^[M|U|G|.]{8}' | cut -d \" \" -f4,5 | while read line;do (echo \`stat -c '%n' \$line\` |tr '\n' ' '; echo \`printf '0%o\n' \"0x\$(stat -c '%f' \$line)\"\` |tr '\n' ' '; echo \`stat -c '%U %G' \$line\`);done > 10010-2.results

cat 10010-1.results

grep -vFf 10010-1.results 10010-2.results

"

for i in `rpm -Va | egrep -i '^[M|U|G|.]{8}' | cut -d " " -f4,5`
do
  for j in `rpm -qf $i`
  do
    rpm -ql $j --dump | cut -d " " -f1,5,6,7 |  grep $i
  done
done > 10010-1.results

rpm -Va | egrep -i '^[M|U|G|.]{8}' | cut -d " " -f4,5 | while read line;do (echo `stat -c '%n' $line` |tr '\n' ' '; echo `printf '0%o\n' "0x$(stat -c '%f' $line)"` |tr '\n' ' '; echo `stat -c '%U %G' $line`);done > 10010-2.results


echo "
~~~~~~~~~~~~VENDOR DEFAULTS~~~~~~~~~~~
"

cat 10010-1.results

echo "
~~~~DO NOT MATCH VENDOR DEFAULTS - MANUAL REVIEW~~~~
"

grep -vFf 10010-1.results 10010-2.results

echo "
If the file is more permissive than the default permissions, this is a finding.

If the file is not owned by the default owner and is not documented with the Information System Security Officer (ISSO), this is a finding.

If the file is not a member of the default group and is not documented with the Information System Security Officer (ISSO), this is a finding.

STIG 10010
"
