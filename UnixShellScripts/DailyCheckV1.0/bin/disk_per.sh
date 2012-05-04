#Script for the percentage of disk space usage.
has01=$(df -mv|cut -c 47-48|tail -n 8)
echo $has01 > mv_output
cat mv_output|read has2 has3 has4 has5 has6 has7 has8 has9
((has_sum=has2+has3+has4+has5+has6+has8+has9))
((has_per=has_sum/7))
has_date=$(date +"%e, %h, %Y")
has_host=$(hostname)
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "The percentage of disk space usage for $has_host is $has_per% for this day $has_date"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
rm -fr mv_output




#script-002 for swap space usage for App1
has10=$(lsps -s|tail -n 1|cut -d "B" -f 2|cut -c 14-16)
echo "The Swap space usage for $has_host is$has10%"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
