#!/bin/bash
###
#
###


echo "#!/bin/bash" > $1-rh7.sh
echo "###" >> $1-rh7.sh
echo "# RHEL-07 - $1" >> $1-rh7.sh
echo "# STIG ID's:" >> $1-rh7.sh
echo "############################################################################

" >> $1-rh7.sh

echo "echo \"STIG $1
" >> $1-rh7.sh

echo "Results:
" >> $1-rh7.sh

echo "STIG $1
\"" >> $1-rh7.sh

chmod 755 $1-rh7.sh
