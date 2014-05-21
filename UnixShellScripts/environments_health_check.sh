#!/bin/bash
#
# SCRIPT: HealthCheck.sh
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

SERVER_NAME=$1
SEPARATOR=","
CURRENT_DATE='date +"%Y%d%m-%H:%M:%S"'

#########################################################################################################################################
# DEFINE FUNCTIONS HERE
#########################################################################################################################################

function checkSystemLoad()
{
        LOAD=$(uptime | awk -F "," '{print $NF}')
        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}${SEPARATOR}${LOAD}"
}

function checkCqProcesses()
{
    procs=java
    owner=cq

    for proc in $procs; do
                count=$(ps -u cq -f | grep -v grep | grep -c java)
                total=""

                if [ $count -eq 0 ]; then
                    echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}${SEPARATOR}${0}"
                    return;
                fi
                echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}${SEPARATOR}${1}"
    done
}

function check_zombies()
{
    proc=$(ps -ef | grep -v grep | grep "<defunct>$")

    if [ -z "$proc" ]; then
                echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME} OK: No zombie process running"
            else

                echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}  ---> WARNING: Zombie processes running"

                echo "$proc"
    fi
    echo
}

function check_memory_demanding_processes()
{
    threshold=100000

    proc=$(ps -efl | tail -n +2 | awk -v big=$threshold '$10 > big && NF >= 14 {print $0}')

    if [ -z "$proc" ]; then
        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME} OK: Each process uses less than $threshold page of memory"
    else
        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME} ---> WARNING: Processes with more than $threshold page of memory"
        echo "$proc"
    fi
    echo
}

function checkSwapSpace()
{
        free -k | grep -i swap | cut -d ":" -f2 | while read TOTAL_SWAP_SPACE USED_SWAP_SPACE FREE_SWAP_SPACE
        do
                if [ "$v1" == "0" ]
                then
                        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME} WARNING: Swap space is not configured!"
                        return;
                else
                        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}${SEPARATOR}${TOTAL_SWAP_SPACE}${SEPARATOR}${USED_SWAP_SPACE}${SEPARATOR}${FREE_SWAP_SPACE}"
                fi
        done

}

function check_system_memory()
{
        TOTAL_MEMORY=$(echo "$(cat /proc/meminfo | grep MemTotal | awk '{print $2}') / 1024 / 1024" | bc -l)
        FREE_MEMORY=$(echo "$(cat /proc/meminfo | grep MemFree | awk '{print $2}') / 1024 / 1024" | bc -l)

        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}${SEPARATOR}${TOTAL_MEMORY}"
        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}${SEPARATOR}${FREE_MEMORY}"
}

function check_java_process_memory_usage()
{
        TOTAL_MEMORY=$(echo "$(cat /proc/meminfo | grep MemTotal | awk '{print $2}') / 1024 / 1024" | bc -l)

        java_process_memory_usage_percentile=$(ps -u cq -C java -L -o pid,tid,nlwp,pcpu,cputime,psr,pmem --sort pmem | head -n 2 | tail -n +2 | awk '{print $7}')
        javaMemoryConsumption=$(echo "$java_process_memory_usage_percentile * $TOTAL_MEMORY / 100" | bc -l)

        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}${SEPARATOR}${javaMemoryConsumption}"
}

function calculate_the_number_of_java_threads_within_cq_process()
{
        number_of_threads=$(ps -u cq -C java -L -o pid,tid,nlwp,pcpu,cputime,psr,pmem --sort pmem | tail -n +2 | wc -l)
        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}${SEPARATOR}${number_of_threads}"
}


function get_the_number_of_threads_per_core()
{
        thread_distribution=$(ps -u cq -C java -L -o pid,tid,nlwp,pcpu,cputime,psr,pmem --sort pmem | awk 'BEGIN {thread_count_core_1=0 ; thread_count_core_2=0 ; thread_count_core_3=0 ; thread_count_core_4=0} { if($6 == 0) thread_count_core_1 +=1; else if($6 == 1) thread_count_core_2 +=1; else if ($6 == 2) thread_count_core_3 +=1; else thread_count_core_4 +=1} END {print thread_count_core_1","thread_count_core_2","thread_count_core_3","thread_count_core_4 }')
        echo "$(eval $CURRENT_DATE)${SEPARATOR}${SERVER_NAME}${SEPARATOR}${thread_distribution}"
}

#########################################################################################################################################
# BEGINNING OF MAIN
#########################################################################################################################################

checkSystemLoad >> /navitas/logs/scheduled/system_load.log

checkCqProcesses >> /navitas/logs/scheduled/cq_processes.log

check_zombies >> /navitas/logs/scheduled/zombie_processes.log

check_memory_demanding_processes >> /navitas/logs/scheduled/memory_demanding_processes.log

checkSwapSpace >> /navitas/logs/scheduled/swap_space.log

check_system_memory >> /navitas/logs/scheduled/system_memory.log

check_java_process_memory_usage >> /navitas/logs/scheduled/java_process_memory_usage.log

calculate_the_number_of_java_threads_within_cq_process >> /navitas/logs/scheduled/number_of_threads.log

get_the_number_of_threads_per_core >> /navitas/logs/scheduled/threads_per_core.log