for day in $(echo "201107020
201107021
201107025
201107027
201107024
201107019
201107022
201107030
201107023
201107028
201107026
201107029
201107031")
do
    NO_OF_DIGITS=$(echo ${day} | wc -c)
    if [ $NO_OF_DIGITS -eq "10" ]
    then
        echo ${day} | sed 's/070/07/g'
    else
        echo ${day}
    fi
done | sort -n # This is to sort the days in an ascending order