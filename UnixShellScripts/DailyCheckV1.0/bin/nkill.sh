#!/usr/bin/ksh
processname=$1
signalnumber=$2
kill -$signalnumber $(ps -ef|grep $processname|grep -v grep|awk '{print $2}') 
