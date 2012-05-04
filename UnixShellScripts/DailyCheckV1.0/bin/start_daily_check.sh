#!/usr/bin/ksh
myDate=$(date +"%OH:%OM.%A.%m%Y")
/test/bin/daily_check.sh>/test/daily_reports/$myDate.doc
mail -s "Daily Check Report" hasanein.ali@asiacell.com</test/daily_reports/$myDate.doc
current_date=`date|awk '{print $1}'`
case $current_date in
Sat)
mv /test/daily_reports/*Saturday* /test/daily_reports/SAT
;;
Mon)
mv /test/daily_reports/*Monday* /test/daily_reports/SUN
;;
Tue)
mv /test/daily_reports/*Tuesday* /test/daily_reports/MON
;;
Wed)
mv /test/daily_reports/*Wednesday* /test/daily_reports/WED
;;
Thu)
mv /test/daily_reports/*Thursday* /test/daily_reports/THU
;;
Fri)
mv /test/daily_reports/*Friday* /test/daily_reports/FRI
;;
Sun)
mv /test/daily_reports/*Sunday* /test/daily_reports/SUN
;;
esac
/test/bin/read_errpt.sh
