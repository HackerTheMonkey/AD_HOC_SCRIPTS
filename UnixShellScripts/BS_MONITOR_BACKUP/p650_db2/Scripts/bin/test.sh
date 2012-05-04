var=$(ping -c 2 192.168.117.20|tail +6|head -1|cut -d , -f3|cut -d % -f1)
echo $var
if [ $var = 0 ]; then
echo "OK,..........."
fi
