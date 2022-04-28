src='/usr/local/etc/stig/scripts'
host=`hostname -s`
date=`date +%Y%m%d`

rm -f $src/${host}*.results

cat $src/10010.results >> ${host}-${date}.results
cat $src/10320.results >> ${host}-${date}.results
cat $src/10330.results >> ${host}-${date}.results
cat $src/10500.results >> ${host}-${date}.results
cat $src/10062-82.results >> ${host}-${date}.results
cat $src/20019.results >> ${host}-${date}.results
cat $src/20020.results >> ${host}-${date}.results
cat $src/20040.results >> ${host}-${date}.results
cat $src/20111.results >> ${host}-${date}.results
cat $src/20210.results >> ${host}-${date}.results
cat $src/20220.results >> ${host}-${date}.results
cat $src/20230.results >> ${host}-${date}.results
cat $src/20231.results >> ${host}-${date}.results
cat $src/20250.results >> ${host}-${date}.results
cat $src/20260.results >> ${host}-${date}.results
cat $src/20270.results >> ${host}-${date}.results
cat $src/20320.results >> ${host}-${date}.results
cat $src/20330.results >> ${host}-${date}.results
cat $src/20630-40-50.results >> ${host}-${date}.results
cat $src/20660-70-80.results >> ${host}-${date}.results
cat $src/20690-700-10.results >> ${host}-${date}.results
cat $src/20720.results >> ${host}-${date}.results
cat $src/20730.results >> ${host}-${date}.results
cat $src/20900.results >> ${host}-${date}.results
cat $src/21000.results >> ${host}-${date}.results
cat $src/21010.results >> ${host}-${date}.results
cat $src/21100.results >> ${host}-${date}.results
cat $src/21022-23-24.results >> ${host}-${date}.results
cat $src/21030.results >> ${host}-${date}.results
cat $src/21031.results >> ${host}-${date}.results
cat $src/21040.results >> ${host}-${date}.results
cat $src/21300.results >> ${host}-${date}.results
cat $src/21600-10-20.results >> ${host}-${date}.results
cat $src/21700.results >> ${host}-${date}.results
cat $src/30330.results >> ${host}-${date}.results
cat $src/31000.results >> ${host}-${date}.results
cat $src/31010.results >> ${host}-${date}.results
cat $src/32000.results >> ${host}-${date}.results
cat $src/40100.results >> ${host}-${date}.results
cat $src/40160.results >> ${host}-${date}.results
cat $src/40180-190-200.results >> ${host}-${date}.results
cat $src/40310.results >> ${host}-${date}.results
cat $src/40500.results >> ${host}-${date}.results
cat $src/40520.results >> ${host}-${date}.results
cat $src/40600.results >> ${host}-${date}.results
cat $src/40611.results >> ${host}-${date}.results
cat $src/40612.results >> ${host}-${date}.results
cat $src/40670.results >> ${host}-${date}.results
cat $src/40680.results >> ${host}-${date}.results
cat $src/40170.results >> ${host}-${date}.results
cat $src/40720.results >> ${host}-${date}.results
cat $src/40750.results >> ${host}-${date}.results
cat $src/40810.results >> ${host}-${date}.results
cat $src/40820.results >> ${host}-${date}.results
cat $src/41010.results >> ${host}-${date}.results
cat $src/910055.results >> ${host}-${date}.results
