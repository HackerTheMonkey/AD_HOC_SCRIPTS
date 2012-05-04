#has1=$(ps -ef|grep pre|cut -d "t" -f 3)
#echo $has1>pre_output
#cat pre_output|read has2 has3 has4 has5 has6 has7 has8 has9 has10 has11 has12 has13 has14
#((hassum=has2+has3+has4+has5+has6+has7+has8+has9+has10+has11+has12+has13+has14))
#echo ""
#echo "the total summation of the pre-treatment processes are $hassum"
#echo ""
#rm -fr pre_output

p_app2=$(ping -q -c 1 192.168.117.21|cut -d "," -f3 -s|cut -d "%" -f1)
if ((p_app2>0))
then
echo "App2 link is either down or unstable and the packet loss is $p_app2%"
fi