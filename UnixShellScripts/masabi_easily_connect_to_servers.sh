#!/bin/sh
function localMysql(){
	mysql -uroot -pr2kogCiKyKq5 $1
}

function dockerMysql(){
	mysql -uroot -pr2kogCiKyKq5 -h$(boot2docker ip) -P13306 $1
}


# To quickly tail all tomcat logs
function logs(){  
  tail -f /usr/local/Cellar/tomcat7/7.0.61/libexec/logs/*.out \
  /usr/local/Cellar/tomcat7/7.0.61/libexec/logs/*.txt \
  /var/hosting/tomcatlogs/justride_mpg.log
}

# run a command against Tomcat docker container
function _()
{
	docker exec $(docker ps | grep $(docker ps | grep masabi/payment-webapp | grep -v db | awk '{print $1}') | awk '{print $1}') "$@"
}

# run a command against Mysql docker container
function __()
{
	docker exec $(docker ps | grep $(docker ps | grep masabi/payment-webapp-db | awk '{print $1}') | awk '{print $1}') "$@"
}

function dockerMpgLogs(){
	_ tail -f /var/hosting/tomcatlogs/justride_mpg.log
}