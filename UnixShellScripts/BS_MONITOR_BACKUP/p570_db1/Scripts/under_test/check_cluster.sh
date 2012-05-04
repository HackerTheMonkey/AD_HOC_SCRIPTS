#!/usr/bin/ksh
echo "Checking HACMP cluster on $HOSTNAME"

#checking the cluster daemons process status:
var1=$(lssrc -g cluster|tail +2|awk '{print $1 " " $4}')
echo $var1|read proc1 stat1 proc2 stat2 proc3 stat3
if [ $stat1 != "active" ];then
	echo "$proc1 is not running"
elif [ $stat2	 != "active" ];then
	echo "proc2 is not running"
elif [ $stat3 != "active" ];then
	echo "$proc3 is not running"
else
	echo "All HACMP daemons are running"
fi

#check the node name is correct or not
server_name=$(hostname)
node_name=$(odmget HACMPcluster|tail +4|tail +2|head -1|cut -d "\"" -f2)
[ $node_name != $server_name ] && echo "server name is $server_name while node name is $node_name"

#checking the cluster status
echo "\n"|clverify cluster config all >/dev/null 2> /tmp/clstat.error
