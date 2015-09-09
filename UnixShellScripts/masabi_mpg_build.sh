#!/bin/sh

# VARIABLES DECLARATION
MPG_SRC_HOME="/Users/hassanein.khafaji/Projects/masabi/mpg"

function mpgBuild()
{
  cd ${MPG_SRC_HOME}
  mvn clean package --projects com.masabi:justride-payment-webapp --also-make -DskipTests $1
}

function mpgBuildWithUnitTests()
{
  cd ${MPG_SRC_HOME}
  mvn clean package --projects com.masabi:justride-payment-webapp --also-make $1 -o
}

function mpgDeploy(){
	MPG_WAR="${MPG_SRC_HOME}/payment-webapp/target/MPG.war"
	TOMCAT_WEBAPPS="/usr/local/Cellar/tomcat7/7.0.61/libexec/webapps"
	CATALINA_SH="/usr/local/Cellar/tomcat7/7.0.61/libexec/bin/catalina.sh"

	# delete the old war and copy the new one.
	cd ${TOMCAT_WEBAPPS}
	rm -fr MPG*
	cp ${MPG_WAR} .

	# restart tomcat
	ps -ef | grep tomcat | grep -v grep | awk '{print $2}' | xargs kill -9
	${CATALINA_SH} start
}

function mpgRedeploy(){
	mpgBuild && mpgDeploy
}

function mpgBuildWithIntegrationTests(){
	cd ${MPG_SRC_HOME}
  	mvn verify --projects com.masabi:justride-payment-webapp --also-make -P WithDocker $1
}

function mpgBuildThenRunDocker(){
	cd ${MPG_SRC_HOME}
  	mvn pre-integration-test --projects com.masabi:justride-payment-webapp --also-make -P WithDocker $1
}

function mpgBuildThenRunDockerAndRunTests(){
	cd ${MPG_SRC_HOME}
  	mvn integration-test --projects com.masabi:justride-payment-webapp --also-make $1
}
