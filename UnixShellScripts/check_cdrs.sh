. ~/.profile
cd /bossapp1/medcdr/OutData/back
cond1="original"
cond2="ASN"
currentDate=`date +"%Y%m%d"`              
#currentDate="20070305"
fileDate1=`date +"%d%m%Y"`
fileDate2=`date +"%Y%m%d"`
echo "Checking the CDRs process status"
for dir in `ls -l|grep "^d"|awk '{print $9}'|grep -v merge|grep -v COL_Prm|grep -v ERB|grep -v COL_G6_SUL|grep -v COL_G9IO_KIR|grep -v COL_RAPIN|grep -v "^\."`
do
	  cd $dir
	  for folder in `ls -l|grep "^d"|awk '{print $9}'`
	  do
			if ( test $folder = $cond1 ) then
				  cd $folder
				  #echo "now we are in ${PWD}"
			elif ( test $folder = $cond2 ) then
				  cd $folder
				  #echo "now we are in ${PWD}"
			fi
			
			ls -l $currentDate > /dev/null 2>&1
			cmdStatus_1=$(echo $?)
			ls -l $currentDate/*$fileDate1*
			cmdStatus_2=$(echo $?)
			ls -l $currentDate/*$fileDate2*
			cmdStatus_3=$(echo $?)
			
			
			if (test $cmdStatus -ne 0) then
			echo "--->Alert: Unbacked/Unprocessed CDRs for ${dir}"
			elif [ $cmdStatus_1 -eq 0 -o $cmdStatus_2 -eq 0 ];then
			echo "OK" > /dev/null
			else
			echo "--->Alert: Unbacked/Unprocessed CDRs for ${dir}"
			fi                                                         
	  done
	  cd ../..
	  #pwd
done