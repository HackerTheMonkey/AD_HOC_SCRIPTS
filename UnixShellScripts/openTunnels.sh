#!/bin/bash
#
# SCRIPT: OpenTunnels.sh
# AUTHOR: Hasanein Khafaji
# DATE: 09/05/2014
# REV: 1.0
# PLATFORM: Platform-Independent
#
# PURPOSE: To facilitate establishing SSH tunnels through bastion that takes care of the
# port forwarding that's neccessary to connect to the servers behind bastion.
#      
# set -x # Uncomment to debug this script
#
# set -n # Uncomment to check script syntax
#        # without aby execution. Do not forget
#        # to put the comment back in or the
#        # script will never execute.
#
#########################################################################################################################################
# DEFINE FILES AND VARIABLES HERE
#########################################################################################################################################
CERTIFICATE_PATH="/Users/hassanein.khafaji/.ssh/navitas.pem"
REMOTE_SSH_PORT="22"

DEV1_BASTION_IP_ADDRESS="46.51.192.181"
TEST1_BASTION_IP_ADDRESS="46.51.203.89"
TEST3_BASTION_IP_ADDRESS="54.229.119.168"


#########################################################################################################################################
# DEFINE FUNCTIONS HERE
#########################################################################################################################################

# Get the IP addresses for all the environments from Amazon

function getTest1AuthorIpAddress()
{
	curl -X GET http://ec2-54-246-169-21.eu-west-1.compute.amazonaws.com/dashboard/index.php/instances/test1 2> /dev/null | jq '.[] as $resultObject | if ($resultObject.name | contains("test1-cq-author"))
	then $resultObject.privateIpAddress
	else
		"no match"
	end
	' | grep -v "no match" | sed 's/"//g'
}

function getTest1PublishIpAddress()
{
	curl -X GET http://ec2-54-246-169-21.eu-west-1.compute.amazonaws.com/dashboard/index.php/instances/test1 2> /dev/null | jq '.[] as $resultObject | if ($resultObject.name | contains("test1-cq-publisher"))
	then $resultObject.privateIpAddress
	else
		"no match"
	end
	' | grep -v "no match" | sed 's/"//g'
}

function getDev1AuthorIpAddress()
{
	curl -X GET http://ec2-54-246-169-21.eu-west-1.compute.amazonaws.com/dashboard/index.php/instances/dev1 2> /dev/null | jq '.[] as $resultObject | if ($resultObject.name | contains("dev1-cq-author"))
	then $resultObject.privateIpAddress
	else
		"no match"
	end
	' | grep -v "no match" | sed 's/"//g'
}

function getDev1PublishIpAddress()
{
	curl -X GET http://ec2-54-246-169-21.eu-west-1.compute.amazonaws.com/dashboard/index.php/instances/dev1 2> /dev/null | jq '.[] as $resultObject | if ($resultObject.name | contains("dev1-cq-publisher"))
	then $resultObject.privateIpAddress
	else
		"no match"
	end
	' | grep -v "no match" | sed 's/"//g'
}

function getTest3PublishIpAddress()
{
	curl -X GET http://ec2-54-246-169-21.eu-west-1.compute.amazonaws.com/dashboard/index.php/instances/test3 2> /dev/null | jq '.[] as $resultObject | if ($resultObject.name | contains("test3-cq-publisher"))
	then $resultObject.privateIpAddress
	else
		"no match"
	end
	' | grep -v "no match" | sed 's/"//g'
}

function getTest3AuthorIpAddress()
{
	curl -X GET http://ec2-54-246-169-21.eu-west-1.compute.amazonaws.com/dashboard/index.php/instances/test3 2> /dev/null | jq '.[] as $resultObject | if ($resultObject.name | contains("test3-cq-publisher"))
	then $resultObject.privateIpAddress
	else
		"no match"
	end
	' | grep -v "no match" | sed 's/"//g'
}

##############################################################################################################################################
# CONFIG FORMAT)   {TUNNEL ALIAS NAME}:{REMOTE SERVER IP ADDRESS}:{LOCAL PORT TO FORWARD FROM}:{REMOTE PORT TO FORWARD TO}:{BASTION IP ADDRESS}
##############################################################################################################################################

DEV1_CONFIG="DEV1-PUBLISH-SSH-TUNNEL:$(getDev1PublishIpAddress):1234:22:${DEV1_BASTION_IP_ADDRESS}
	DEV1-AUTHOR-SSH-TUNNEL:$(getDev1AuthorIpAddress):1235:22:${DEV1_BASTION_IP_ADDRESS}
	DEV1-PUBLISH-OSGI-CONSOLE-TUNNEL:$(getDev1PublishIpAddress):45031:4503:${DEV1_BASTION_IP_ADDRESS}"

TEST1_CONFIG="TEST1-PUBLISH-SSH-TUNNEL:$(getTest1PublishIpAddress):1236:22:${TEST1_BASTION_IP_ADDRESS}
	TEST1-AUTHOR-SSH-TUNNEL:$(getTest1AuthorIpAddress):1237:22:${TEST1_BASTION_IP_ADDRESS}
	TEST1-PUBLISH-OSGI-CONSOLE-TUNNEL:$(getTest1PublishIpAddress):45032:4503:${TEST1_BASTION_IP_ADDRESS}"

TEST3_CONFIG="TEST3-PUBLISH-SSH-TUNNEL:$(getTest3PublishIpAddress):1238:22:${TEST3_BASTION_IP_ADDRESS}
	TEST3-AUTHOR-SSH-TUNNEL:$(getTest3AuthorIpAddress):1239:22:${TEST3_BASTION_IP_ADDRESS}"	

CONFIG="	
	$TEST1_CONFIG
	$DEV1_CONFIG	
"

##############################################################################################################################################
# The remainder of the functions definitions.
##############################################################################################################################################

function openAllTunnels()
{	

	for configLine in $CONFIG
	do 
		TUNNEL_NAME=$(echo $configLine | grep -v '^$' | cut -d ":" -f1)
		REMOTE_SERVER_IP_ADDRESS=$(echo $configLine | grep -v '^$' | cut -d ":" -f2)		
		LOCAL_PORT=$(echo $configLine | grep -v '^$'  | cut -d ":" -f3)		
		REMOTE_PORT=$(echo $configLine | grep -v '^$' | cut -d ":" -f4)
		BASTION_IP_ADDRESS=$(echo $configLine | grep -v '^$' | cut -d ":" -f5)
				
		openTunnel ${CERTIFICATE_PATH} ${BASTION_IP_ADDRESS} ${LOCAL_PORT} ${REMOTE_SERVER_IP_ADDRESS} ${REMOTE_PORT}

		if [ $? -eq "0" ]
		then
			echo "Tunnel ${TUNNEL_NAME} has been opened"
		else
			echo "Something went wrong while attempting to establish ${TUNNEL_NAME} tunnel!"
			echo "Executed command: openTunnel ${CERTIFICATE_PATH} ${BASTION_IP_ADDRESS} ${LOCAL_PORT} ${REMOTE_SERVER_IP_ADDRESS} ${REMOTE_PORT}"
		fi
	done	
}

function openTunnel()
{
	 ssh -i ${1} -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" navitas@${2} -L:${3}:${4}:${5} -f -N &> /dev/null	 
}

function dev1-pub()
{	
	ssh -i ~/.ssh/navitas.pem -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" navitas@localhost -p 1234
}

function dev1-author()
{	
	ssh -i ~/.ssh/navitas.pem navitas@localhost -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -p 1235
}

function test1-pub()
{	
	ssh -i ~/.ssh/navitas.pem navitas@localhost -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -p 1236
}

function test1-auth()
{	
	ssh -i ~/.ssh/navitas.pem navitas@localhost -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -p 1237
}

function test3-pub()
{	
	ssh -i ~/.ssh/navitas.pem navitas@localhost -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -p 1238
}

function test3-auth()
{	
	ssh -i ~/.ssh/navitas.pem navitas@localhost -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -p 1239
}











