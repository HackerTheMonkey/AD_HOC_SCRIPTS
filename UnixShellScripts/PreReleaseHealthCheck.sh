#!/bin/bash
#
# SCRIPT: PreReleaseHealthCheck.sh
# AUTHOR: Hasanein Khafaji
# DATE: 04/07/2014
# REV: 1.0
# PLATFORM: Platform-Independent
#
# PURPOSE: To make it easy to identify if there are any outlier stories that are commited into the sprint accidentally and that they are
# not supposed to be within this sprint.
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

export CURRENT_RELEASE="navitas-bau-release-2.0.9.0"
export PREVIOUS_RELEASE="master"

export EXPECTED_STORIES="
SS-2979
SS-3257
SS-3258
SS-3358
SS-3359
SS-3360
SS-3371
SS-3147
SS-2971
SS-2970
SS-2819"

#########################################################################################################################################
# DEFINE FUNCTIONS HERE
#########################################################################################################################################

function getOutlierStories()
{
    for story in $(git log --pretty=%s ${PREVIOUS_RELEASE}..${CURRENT_RELEASE} | sed 's/.*\(SS-[0-9]*\).*/\1/g' | grep 'SS-[0-9]*' | sort -u)    
    do        
        echo ${EXPECTED_STORIES} | grep ${story} &> /dev/null
        if [ $? -eq 1 ] ; then
            echo "${story} is an outlier"
        fi
    done
}

#########################################################################################################################################
# BEGINNING OF MAIN
#########################################################################################################################################

getOutlierStories