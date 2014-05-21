#!/bin/bash
while(true)
do
	for server in "localhost:45031" "localhost:45032"
	do
		sentDate=$(date)
		curl http://${server}/content/bp/en/global/corporate/products-and-services.html &> /dev/null
		receiveDate=$(date)
		echo "$(date),${server},${sentDate},${receiveDate}"
	done
done > response_times.log&	