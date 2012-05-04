#!/bin/sh
########################################################################
# Script name : monitor_systems.sh
# Description : Monitor all UNIX Billing Systems
# Written by  : Edi Cahyadi  (07/04/2007)
########################################################################

list=/Scripts/etc/monitor_systems.txt

/Scripts/bin/monitor_system.sh		# this server (p615_bk)
sleep 30
for server in $(cat $list); do		# other servers
    /Scripts/bin/monitor_rsystem.sh $server
    sleep 30
done
