#day_of_month_1=`date +"%d"`;echo `expr $day_of_month_1 - 01`
day_of_month_1=12
day_of_month_2=`expr $day_of_month_1 - 01`
if (( day_of_month_1<11 ))
then
echo "first cond"
day_of_month_3="0$day_of_month_2"
fi
if (( day_of_month_1>=11  ))
then
echo "second cond."
day_of_month_3=$day_of_month_2
fi
echo "day1 is $day_of_month_1"
echo "day2 is $day_of_month_2"
echo "day3 is $day_of_month_3"