#!/usr/bin/ksh

echo "###################################################################################################################################"
echo "################################ Daily Check Procedure for Billing System (BS)-Network Elements (NE's)#############################"
echo "###################################################################################################################################"

echo "------------------------------------------------------------------"


link=$(ping -q -c 10 192.168.105.11|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Suly HQ SMU link is either down or unstable and the packet loss is $link%"
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.90.20|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Kirkuk SMU Server link is either down or unstable and the packet loss is $link%"
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.8.20|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Mosul SMU Server link is either down or unstable and the packet loss is $link%"
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.0.20|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Baghdad SMU Server link is either down or unstable and the packet loss is $link%"
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.16.20|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Basra SMU Server link is either down or unstable and the packet loss is $link%"
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.100.6|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Suly Ali Namaly SMU Server link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.105.11|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Suly HQ AUC link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.90.20|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Kirkuk AUC link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.8.20|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Mosul AUC link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.0.20|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Baghdad AUC link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 192.168.16.20|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Basra AUC link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 10.76.100.24|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Suly 1 SMP link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 10.76.105.40|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Suly HQ SMP link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 10.74.110.24|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Kirkuk SMP link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 10.76.8.30|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Mosul SMP link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi
link=""
link=$(ping -q -c 10 10.76.16.10|cut -d "," -f3 -s|cut -d "%" -f1)
if ((link>0))
then
echo "Basra SMP link is either down or unstable and the packet loss is $link% "
echo "------------------------------------------------------------------"
echo ""
fi