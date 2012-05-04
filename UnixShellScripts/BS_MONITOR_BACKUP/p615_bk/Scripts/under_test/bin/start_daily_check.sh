#!/usr/bin/ksh
myDate=$(date +"%OH:%OM.%A.%m%Y")
/Scripts/bin/daily_check.sh>/Scripts/daily_reports/$myDate.doc
#mail -s "Daily Check Report" hasanein.ali@asiacell.com</Scripts/daily_reports/$myDate.doc
uuencode /Scripts/daily_reports/$myDate.doc Daily_Check_Report.log|mail -s "Daily Check Report" hasanein.ali@asiacell.com
#mail -s "Daily Check Report" pouyan.sepahvand@asiacell.com</Scripts/daily_reports/$myDate.doc
current_date=`date|awk '{print $1}'`
case $current_date in
Sat)
mv /Scripts/daily_reports/*Saturday* /Scripts/daily_reports/SAT
;;
Mon)
mv /Scripts/daily_reports/*Monday* /Scripts/daily_reports/SUN
;;
Tue)
mv /Scripts/daily_reports/*Tuesday* /Scripts/daily_reports/MON
;;
Wed)
mv /Scripts/daily_reports/*Wednesday* /Scripts/daily_reports/WED
;;
Thu)
mv /Scripts/daily_reports/*Thursday* /Scripts/daily_reports/THU
;;
Fri)
mv /Scripts/daily_reports/*Friday* /Scripts/daily_reports/FRI
;;
Sun)
mv /Scripts/daily_reports/*Sunday* /Scripts/daily_reports/SUN
;;
esac
/Scripts/bin/read_errpt.sh