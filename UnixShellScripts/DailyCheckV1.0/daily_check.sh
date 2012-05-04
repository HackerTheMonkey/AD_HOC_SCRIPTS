#!\usr/bin/ksh
echo "###################################################################################################################################"
echo "############################################# Daily Check Procedure for P630_App1##################################################"
echo "###################################################################################################################################"
echo ""
echo ""
rexec p630_app1 echo "-------------------------------"
echo ""
rexec p630_app1 echo "Checking the disk space usage"
echo ""
rexec p630_app1 df -mv
echo ""
rexec p630_app1 echo "-------------------------------"
rexec p630_app1 echo "Checking the percentage use of Swap Space"
echo ""
rexec p630_app1 lsps -s
rexec p630_app1 echo "------------------------------"
rexec p630_app1 echo "Checking the CDR Collection Processes"
rexec p630_app1 ps -ef|grep proc|grep -v grep|wc -l>no.proc
read proc_no<no.proc
echo "the number of running collection processes is $proc_no"
rexec p630_app1 echo "------------------------------"
rexec p630_app1 ps -ef|grep proc
rexec p630_app1 echo "------------------------------"
rexec p630_app1 echo "Checking the CDR Pretreat Processes"
rexec p630_app1 ps -ef|grep pre|grep -v grep|wc -l>no.pre
read pre_no<no.pre
echo "the number of running pretreat processes is $pre_no"
rexec p630_app1 echo "------------------------------"
rexec p630_app1 ps -ef|grep pre
rexec p630_app1 echo "------------------------------"
rexec p630_app1 echo "check the billing processes"
rexec p630_app1 echo "------------------------------"
rexec p630_app1 ps -ef|grep billing
rexec p630_app1 echo "------------------------------"
rexec p630_app1 echo "Checking the MedSer processes"
rexec p630_app1 echo "------------------------------"
rexec p630_app1 ps -ef|grep medser
rm -fr no.proc
rm -fr no.pre
echo "			"
echo "			"
echo "			"
echo "			"
echo "###################################################################################################################################"
echo "############################################# Daily Check Procedure for P630_App2##################################################"
echo "###################################################################################################################################"
echo ""
echo ""
rexec p630_app2 echo "-------------------------------"
echo ""
rexec p630_app2 echo "Checking the disk space usage"
echo ""
rexec p630_app2 df -mv
echo ""       2
rexec p630_app2 echo "-------------------------------"
rexec p630_app2 echo "Checking the percentage use of Swap Space"
echo ""       2
rexec p630_app2 lsps -s
rexec p630_app2 echo "------------------------------"
rexec p630_app2 echo "Checking the Rating Processes"
rexec p630_app2 echo "------------------------------"
rexec p630_app2 ps -ef|grep rating
rexec p630_app2 echo "------------------------------"
rexec p630_app2 echo "Checking the PRM Processes"
rexec p630_app2 echo "------------------------------"
rexec p630_app2 ps -ef|grep prm
rexec p630_app2 echo "------------------------------"
rexec p630_app2 echo "check the weblogic processes"
rexec p630_app2 echo "------------------------------"
rexec p630_app2 ps -ef|grep weblogic
rexec p630_app2 echo "------------------------------"
echo "			"
echo "			"
echo "			"
echo "			"
echo "###################################################################################################################################"
echo "############################################# Daily Check Procedure for p650_db1##################################################"
echo "###################################################################################################################################"
echo ""
echo ""
rexec p650_db1 echo "-------------------------------"
echo ""
rexec p650_db1 echo "Checking the disk space usage"
echo ""
rexec p650_db1 df -mv
echo ""       
rexec p650_db1 echo "-------------------------------"
rexec p650_db1 echo "Checking the percentage use of Swap Space"
echo ""       
rexec p650_db1 lsps -s
rexec p650_db1 echo "------------------------------"
rexec p650_db1 echo "Checking Oracle Processes"
rexec p650_db1 echo "------------------------------"
rexec p650_db1 ps -ef|grep ora
rexec p650_db1 echo "------------------------------"
echo "			"
echo "			"
echo "			"
echo "			"
echo "###################################################################################################################################"
echo "############################################# Daily Check Procedure for p650_db2##################################################"
echo "###################################################################################################################################"
echo ""
echo ""
rexec p650_db2 echo "-------------------------------"
echo ""
rexec p650_db2 echo "Checking the disk space usage"
echo ""
rexec p650_db2 df -mv
echo ""       
rexec p650_db2 echo "-------------------------------"
rexec p650_db2 echo "Checking the percentage use of Swap Space"
echo ""       
rexec p650_db2 lsps -s
rexec p650_db2 echo "------------------------------"
rexec p650_db1 echo "Checking Oracle Processes"
rexec p650_db2 echo "------------------------------"
rexec p650_db2 ps -ef|grep ora
rexec p650_db2 echo "------------------------------"
