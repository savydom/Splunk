#!/bin/bash

# Find mismatch between vendor default and actual permissions/ownership.

grep -vFf 10010-1.results 10010-2.results | awk '{print $1}' > 10010-3.results

# Associate files to packages.

cat 10010-3.results | while read line;do rpm -qf $line;done > 10010-4.results

# Eliminate redundant entries; reset permissions/ownership.

uniq 10010-4.results | while read line;do rpm --setugids $line;done

uniq 10010-4.results | while read line;do rpm --setperms $line;done

rm -f 10010-1.results
rm -f 10010-2.results
rm -f 10010-3.results
rm -f 10010-4.results
