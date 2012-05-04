#!/usr/bin/ksh

echo "###################################################################################################################################"
echo "################################ Daily Check Procedure for Billing System (BS)-Network Elements (NE's)#############################"
echo "###################################################################################################################################"

echo "------------------------------------------------------------------"

check_link (){
ipaddress=$1
myhostname=$2
link=$(ping -q -c 10 $ipaddress|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "$myhostname link is either down or unstable and the packet loss is $link%"
echo "------------------------------------------------------------------"
echo ""
fi
}