#!/bin/sh 
########################################################################
# Script name : monitor_system.sh
# Description : Monitor UNIX system
# Written by  : Edi Cahyadi  (04/04/2007)
########################################################################

server=$(hostname)
functions=/Scripts/bin/monitoring_functions
alert_file=/Scripts/log/$(basename $0).$server
emerg_file=$alert_file.emerg
[ -f $alert_file ] && rm $alert_file
[ -f $emerg_file ] && rm $emerg_file
hour=$(date +%H)

[ -f $functions ] && . $functions

check_VG_LV ()
{
    flag=0

    echo "Checking volume groups"
    for vg in $(lsvg -o); do
	lsvg -p $vg | tail +3 | while read pv state junk; do
	    if [ "$state" != "active" ]; then
		echo "---> Alert: State of PV $pv of VG $vg is $state" | tee -a $emerg_file
		flag=1
	    fi
	done
	lsvg -l $vg | tail +3 | awk '{print $1, $6}' | grep stale | while read lv state; do
	    echo "---> Alert: State of LV $lv of VG $vg is $state" | tee -a $emerg_file
	    flag=1
	done
    done
    if [ $flag -eq 0 ]; then
	echo "OK: All volume groups are OK"
    fi
    echo
}

check_filesystem ()
{
    threshold1=80
    threshold2=95
    flag=0

    echo "Checking file systems"
    df | grep "[0-9]%" | awk '{print $4, $7}' | while read usage fs; do
	usage=$(echo $usage | tr -d '%')
	msg="---> Alert: $fs file system usage = $usage%"
	if [ $usage -gt $threshold1 ]; then
	    echo "$msg"
	    if [ $usage -gt $threshold2 ]; then
		echo "$msg" >> $emerg_file
	    fi
	    flag=1
	fi
	lnf=$fs/lost+found
	if [ -d $lnf ]; then
	    count=$(ls $lnf | wc -l)
	    if [ $count -gt 0 ]; then
		echo "---> Alert: $lnf has $count files"
		flag=1
	    fi
	else
	    echo "---> Alert: $fs has no lost+found directory"
	    flag=1
	fi
    done
    if [ $flag -eq 0 ]; then
	echo "OK: filesystem usages are all OK"
    fi
    echo
}

check_system_load ()
{
    threshold1=1
    threshold2=5
    load=$(uptime | awk -F, '{print $NF}')

    echo "Checking system Load"
    msg="---> Alert: Current system load is $load"
    if [ $(echo $load | tr -d '.') -gt $(($threshold1 * 100)) ]; then
	echo "$msg"
	if [ $(echo $load | tr -d '.') -gt $(($threshold2 * 100)) ]; then
	    echo "$msg" >> $emerg_file
	fi
    else
	echo Ok: Current system load is $load
    fi
    echo
}

check_proc ()
{
    flag=0
    group=$1
    procs="$2"
    owner=$3
    narg=$#

    echo "Checking $owner's $group processes"
    for proc in $procs; do
	count=$(ps -u $3 -f | grep -v grep | grep -c $proc)
	total=""
	if [ $count -eq 0 ]; then
	    echo "---> Alert: $owner's $proc is not running" | tee -a $emerg_file
	    flag=1
	elif [ $narg -eq 4 ]; then
	    total="$count "
	    if [ $count -lt $4 ]; then
		echo "---> Alert: Not all $owner's ${proc}s are running" | tee -a $emerg_file
		flag=1
	    fi
	fi
    done
    if [ $flag -eq 0 ]; then
	totproc=$(echo $procs | wc -w)
	[ $totproc -gt 1 ] && tobe=are || tobe=is
	echo OK: $total$owner\'s $procs $tobe running
    fi
    echo
}

check_sys_processes ()
{
    owner=root
    sys_proc="inetd cron qdaemon syslogd"
    check_proc System "$sys_proc" $owner
}

check_zombies ()
{
    echo "Checking zombie processes"
    proc=$(ps -ef | grep -v grep | grep "<defunct>$")
    if [ -z "$proc" ]; then
	echo "OK: No zombie process running"
    else
	echo "---> Alert: Zombie processes running"
	echo "$proc"
    fi
    echo
}

check_processes ()
{
    check_sys_processes
    . /Scripts/bin/check_app_processes
    check_zombies
}

check_memory ()
{
    threshold=100000

    echo "Checking memory of each process"
    proc=$(ps -efl | tail +2 | awk -v big=$threshold '$10 > big && NF >= 14 {print $0}')
    if [ -z "$proc" ]; then
	echo "OK: Each process uses less than $threshold page of memory"
    else
	echo "---> Alert: Processes with more than $threshold page of memory"
	echo "$proc"
    fi
    echo
}

check_swap ()
{
    threshold=80

    echo "Checking swap space"
    swap_usage=$(lsps -s | tail -1 | awk '{print $NF}' | tr -d '%')
    if [ $swap_usage -gt $threshold ]; then
        echo "---> Alert: Swap space usage is $swap_usage% used" | tee -a $emerg_file
    else
        echo "OK: Swap space usage is $swap_usage%"
    fi
    echo
}

check_kernel ()
{
    proc_threshold=80
    file_threshold=80

    echo "Checking for kernel process tables and open file tables"
    sar -v 1 1 | grep [^$] | tail -1 | awk '{print $2, $4}' | sed 's#/# #g' | read proc_v proc_l file_v file_l
    proc_pct=$(($(($proc_v * 100)) / proc_l))
    file_pct=$(($(($file_v * 100)) / file_l))
    if [ $proc_pct -gt $proc_threshold ]; then
	echo "---> Alert: Kernel-process usage $proc_pct% exceeded $proc_threshold%"
    else
	echo "OK: Kernel-process usage below $proc_threshold%"
    fi
    if [ $file_pct -gt $file_threshold ]; then
	echo "---> Alert: Kernel-open file usage $file_pct% exceeded $file_threshold%"
    else
	echo "OK: Kernel-open file usage below $file_threshold%"
    fi
    echo
}

check_printq ()
{
    qdir=/var/spool/lpd/qdir

    echo "Checking print queue"
    count=$(ls $qdir | wc -l)
    if [ $count -eq 0 ]; then
	echo "OK: Print queue is empty"
    else
	echo "---> Alert: Print queue is not empty"
    fi
    echo
}

check_mailq ()
{
    qdir=/var/spool/mqueue

    echo "Checking mail queue"
    count=$(ls $qdir | wc -l)
    if [ $count -eq 0 ]; then
	echo "OK: Mail queue is empty"
    else
	echo "---> Alert: Mail queue is not empty"
    fi
    echo
}


# Main Program
clear
echo "***** Checking System Health of $server *****"	| tee -a $alert_file
echo							| tee -a $alert_file
check_VG_LV						| tee -a $alert_file
check_filesystem					| tee -a $alert_file
check_system_load					| tee -a $alert_file
check_processes						| tee -a $alert_file
check_memory						| tee -a $alert_file
check_swap						| tee -a $alert_file
check_kernel						| tee -a $alert_file
check_printq						| tee -a $alert_file
check_mailq						| tee -a $alert_file
[ "$server" = p615_bk ] && check_conn $emerg_file	| tee -a $alert_file
[ "$server" = p615_bk ] && check_ftp $emerg_file	| tee -a $alert_file
[ "$server" = p615_bk ] && send_alerts $server $alert_file
[ "$server" = p615_bk ] && send_emergs $server $emerg_file
