#####################################################################################
#!/bin/bash
#####################################################################################
# Script Name: separate_atheer_trunks_1150.sh
#	Author: Hasanein Ali / Billing System
# Creation Date: 21/4/2008
# Update Date: N/A
# Updated By: N/A
#	Description: The script will separate the incoming calls and the outgoing
# calls via the IN/OUT trunks of 1150.
# The script will change the CDR type from 5 (TRANSIT) to 3 (GWI) for the case of
# the incoming calls, and 5(TRANSIT) to 4 (GWO) in the case of the GWO records.
#####################################################################################
for dir in 2008*
do
	cd $dir
	     for file in *.MID
	     do
		echo "$(date) >> Extracting Trunk In Information from $file"
		awk '{if ($4=="1150") {print $0}}' $file >> /data/BAG_G9_IO/REFORMATTED_CDRS/${dir}/${file}.IN
		echo "$(date) >> Changing the CDR type from TRANSIT to GWI for /data/BAG_G9_IO/REFORMATTED_CDRS/${dir}/${file}.IN"
		sed 's/^5/3/g' /data/BAG_G9_IO/REFORMATTED_CDRS/${dir}/${file}.IN >> /data/BAG_G9_IO/REFORMATTED_CDRS/${dir}/${file}.IN.reformatted
		echo "$(date) >> Extracting Trunk Out Information from $file"
		awk '{if ($5=="1150") {print $0}}' $file >> /data/BAG_G9_IO/REFORMATTED_CDRS/${dir}/${file}.OUT
		echo "$(date) >> Changing the CDR type from TRANSIT to GWO for /data/BAG_G9_IO/REFORMATTED_CDRS/${dir}/${file}.OUT"
		sed 's/^5/4/g' /data/BAG_G9_IO/REFORMATTED_CDRS/${dir}/${file}.OUT >> /data/BAG_G9_IO/REFORMATTED_CDRS/${dir}/${file}.OUT.reformatted
	     done	
	cd ../
done