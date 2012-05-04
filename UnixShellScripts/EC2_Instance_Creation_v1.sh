#!/bin/bash
#
# SCRIPT: Amazon_EC2_Test.sh
# AUTHOR: Hasanein Khafaji
# DATE: 20/02/2012
# REV: 1.0
# PLATFORM: Platform-Independent
#
# PURPOSE: 
#      
# set -x # Uncomment to debug this script
#
# set -n # Uncomment to check script syntax
#        # without aby execution. Do not forget
#        # to put the comment back in or the
#        # script will never execute.
#
##########################################
# DEFINE FILES AND VARIABLES HERE
##########################################
AMI_TYPE="ami-4b814f22"
JETTY_VERSION=$2
NUMBER_OF_INSTANCES=
SCRIPTNAME=$(basename $0)
JETTY_INSTALLATION_TMP_SCRIPT_FILENAME="/Users/hasaneinali/tmp/install_jetty.sh"
export AWS_HOME="/Users/hasaneinali/opt/ec2-api-tools-1.5.2.4"
export PATH=${AWS_HOME}/bin:$PATH
##########################################
# DEFINE FUNCTIONS HERE
##########################################


##########################################
# Print out the general usage information
function printUsage
{
	echo "[${SCRIPTNAME}] -n [number-of-instances] jetty-version"
}


##########################################
# Use the EC2 command line tools to launch the
# desired number of insatnces
# Here we following the default behaviour of the ec2-run-instances
# when setting the private key, the EC2_PRIVATE_KEY should be set
# to the user's own private key as well as the EC2_CERT for the certificate
function launchInstances()
{
	# Check if the user did set the EC2_PRIVATE_KEY & the EC2_CERT
	# environment variables, warn and exit otherwise
	checkEnvVariables
	
	NO_OF_INSTANCES_TO_LAUNCH=$1
	# run the specified number of instances
	ec2-run-instances ${AMI_TYPE} -n ${NO_OF_INSTANCES_TO_LAUNCH}
	
	# Create and Deloy the jetty installation script
	echo "Install Jetty on the created instances..."
	
	createJettyInstallationScript
	wait
	deployJettyInstallationScript		
}
##########################################


function checkEnvVariables()
{
	echo "[${SCRIPTNAME}] -n [number-of-instances] jetty-version"
}

function deployJettyInstallationScript()
{
	# Iterate over the created instance IDs, wait for each to start up before
	# connecting to it
	for INSTANCE_ID in $(ec2-describe-instances | grep ^INSTANCE | awk '{print $2}')
	do
		# Wait for the instance to start
		echo -n "Waiting for instance with $INSTANCE_ID to start up..."
		while INSTANCE_IP_ADDRESS=$(ec2-describe-instances | grep ^INSTANCE | grep ${INSTANCE_ID} | grep -i "running" | awk '{print $13}') && test -z $INSTANCE_IP_ADDRESS
		do
			sleep 3
		done
		
		# Connect to the instance and deploy the jetty installation script
		scp -i ${JETTY_INSTALLATION_TMP_SCRIPT_FILENAME} ~/.ssh/hasaneinkey.txt ${INSTANCE_IP_ADDRESS}:/tmp 
		
		# Run the Jetty Installation Script
		ssh -o StrictHostKeyChecking=no -i ~/.ssh/hasaneinkey.txt ${INSTANCE_IP_ADDRESS} "bash /tmp/$(basename $JETTY_INSTALLATION_TMP_SCRIPT_FILENAME)"
	done
	
	# Get the IP addresses of the running instances, connect to them
	# then download, run and install jetty
}

# Download the specified version of jetty using wget,
function createJettyInstallationScript()
{
	# Download the desired version of jetty
	echo "\#!/bin/bash" >> ${JETTY_INSTALLATION_TMP_SCRIPT_FILENAME}
	echo "cd /tmp" >> ${JETTY_INSTALLATION_TMP_SCRIPT_FILENAME}
	echo "wget http://dist.codehaus.org/jetty/${JETTY_VERISON}/${JETTY_VERISON}.jar" >> ${JETTY_INSTALLATION_TMP_SCRIPT_FILENAME}
	
	# Install Jetty
	
	# Start Jetty
}
##########################################
# BEGINNING OF MAIN
##########################################

while getopts n: OPTION
do
	case $OPTION in
		n) 
			# Set the number of instances to launch
			NUMBER_OF_INSTANCES=$OPTARG
			JETTY_VERSION=$2
			
			# Launch the new instances from the configured AMI
			echo "Launching ${NUMBER_OF_INSTANCES} new ${AMI_TYPE} instances..."
			launchInstances ${NUMBER_OF_INSTANCES}			
		;;
		\?)
			printUsage
		;;
	esac
done
##########################################
# END OF random_file.bash SCRIPT
##########################################
