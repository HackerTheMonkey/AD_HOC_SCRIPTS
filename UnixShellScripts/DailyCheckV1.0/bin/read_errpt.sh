#!/usr/bin/ksh
#This shell script is used for checking the error logs on the billing servers 
#and send one email with one attachment every day at 9:00 AM ; Author: Hasanein
. ~/.profile


#setting the environment variables required for the operation of the shell script.

day_of_month_1=`date +"%d"`
day_of_month_2=`expr $day_of_month_1 - 01`

#this condition will be added just to overcome the problem of having "7" rather than "07" in the day_of_month.

if (( day_of_month_1<11 ))  #if day of month contain only one digit then add a leading zero in the beginning.
then
day_of_month_3="0$day_of_month_2"
fi
if (( day_of_month_1>=11  ))   #if the day of month consist of two digits, then leave it.
then
day_of_month_3=$day_of_month_2
fi

month_of_year=`date +"%m"`
year=`date +"%y"`
current_time=`date +"%T"|cut -d ":" -f1`
#echo $current_time


#checking the current time, we want to check the error logs every day at 9:00 AM.

if (($current_time==16))			#setting the time of excution of the script
then

#clearing the files of any existing text
echo "">/test/error_reports/app1_errors.log
echo "">/test/error_reports/app2_errors.log
echo "">/test/error_reports/db1_errors.log
echo "">/test/error_reports/db2_errors.log

#adding Headers to each one of the files.
echo "App1 Errors Log">/test/error_reports/app1_errors.log
echo "App2 Errors Log">/test/error_reports/app2_errors.log
echo "DB1 Errors Log">/test/error_reports/db1_errors.log
echo "DB2 Errors Log">/test/error_reports/db2_errors.log

#getting errpt output and save it in a file, adding a white space after each header.
rexec p630_app1 errpt -s $month_of_year$day_of_month_3"0000"$year -aD>>/test/error_reports/app1_errors.log
echo "">>/test/error_reports/app1_errors.log
echo "">>/test/error_reports/app1_errors.log
echo "">>/test/error_reports/app1_errors.log
rexec p630_app2 errpt -s $month_of_year$day_of_month_3"0000"$year -aD>>/test/error_reports/app2_errors.log
echo "">>/test/error_reports/app2_errors.log
echo "">>/test/error_reports/app2_errors.log
echo "">>/test/error_reports/app2_errors.log
rexec p650_db1 errpt -s $month_of_year$day_of_month_3"0000"$year -aD>>/test/error_reports/db1_errors.log
echo "">>/test/error_reports/db1_errors.log
echo "">>/test/error_reports/db1_errors.log
echo "">>/test/error_reports/db1_errors.log
rexec p650_db2 errpt -s $month_of_year$day_of_month_3"0000"$year -aD>>/test/error_reports/db2_errors.log
echo "">>/test/error_reports/db2_errors.log
echo "">>/test/error_reports/db2_errors.log
echo "">>/test/error_reports/db2_errors.log

#concatinating all the files in one single file and encoding it and sending it as an attachment.
cat /test/error_reports/app1_errors.log /test/error_reports/app2_errors.log /test/error_reports/db1_errors.log /test/error_reports/db2_errors.log >/test/error_reports/error_report.rtf
uuencode /test/error_reports/error_report.rtf  Error_Report.rtf|mail -s "Error Report" hasanein.ali@asiacell.com
#echo $month_of_year$day_of_month_3"0000"$year		#for debugging purposes
fi
#clear all the variables used by the script
day_of_month_1=""
day_of_month_2=""
month_of_year=""
year=""
current_time=""
