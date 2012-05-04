#!/bin/sh
check_conn ()
{
		#NE_List="/Scripts/under_test/NE_LIST.txt"
		NE_IP=192.168.117.199
		var=`ping -c 2 $NE_IP|grep '%'|cut -d "," -f3|cut -d "%" -f1`		
		if `expr $var > 50`; then
			echo "---> Alert: $1 packet loss is ${var}%"				
		fi
		
}


check_conn WEB