#!/bin/sh
########################################################################
# Script name : monitor_rsystem.sh
# Description : Monitor a remote UNIX system
# Written by  : Edi Cahyadi  (07/04/2007)
########################################################################

if [ $# -ne 1 ]; then
    echo "Usage: $(basename $0) <server>"
    exit 1
fi

server=$1

alert_file=/tmp/$server.$$
emerg_file=$ralert_file.emerg
script=/Scripts/bin/monitor_system.sh
ralert_file=/Scripts/log/$(basename $script).$server
remerg_file=$ralert_file.emerg
hour=$(date +%H)

. /Scripts/bin/monitoring_functions
 
rexec $server $script
if [ $hour -eq 7 -o $hour -eq 13 ]; then
    rcp $server:$ralert_file $alert_file
    send_alerts $server $alert_file
    [ -f $alert_file ] && rm $alert_file
fi

rcp $server:$remerg_file $emerg_file 2> /dev/null
send_emergs $server $emerg_file
[ -f $emerg_file ] && rm $emerg_file
