#!/bin/bash
fileNameToSearch=$1
currentDir=.
isFound=1
# Search all the JAR files contained in the current directory
# for a specific filename given on the command line
for jarFile in $(find ${currentDir} -name '*.jar')
do
	jar -tvf ${jarFile} | grep ${fileNameToSearch} > /dev/null 2>&1
	result=$?
	if (test ${result} == 0)
	then
		echo "${fileNameToSearch} found in ${jarFile}"
		isFound=0
	fi
done
# If the filename is not found, print a message
if(test ${isFound} == 1)
then
	echo "${fileNameToSearch} is not found..."
fi