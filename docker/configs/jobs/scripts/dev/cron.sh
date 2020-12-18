#!/bin/bash 
# USE: 
#   ./cron.sh minute|hour|day|month|year time
# For time values:
#   minute : 1|5|15|30
#   hour   : 1|3|6|12
#   day    : 1|7|15
#   month  : 1|3|6
#   year   : 1
# In case another time value is  needed, you have to add it to crontab
# Examples of use: 
#   ./cron.sh minute 1
#   ./cron.sh hour 3
#   ./cron.sh year 1
if [ "$1" != "" ]; then
    periodicity=$1
else
    echo "periodicity is needed"
    exit
fi
if [ "$2" != "" ]; then
    value=$2
else
    echo "value is needed"
    exit
fi
if [ "$3" != "" ]; then
    debug=$3
else
    debug=false
fi

d=$(date)
log_main="/crons/main/${periodicity}"
mkdir -p log_main
log_main="${log_main}/${value}.log"
touch log_main
if [ "$debug" == true ]; then
    text="Debug: $d. Every $value ${periodicity}"
else
    text="$d. Every $value ${periodicity}"
fi

if [ "$value" != "1" ]; then
    echo "${text}s." >> $log_main
else
    echo "${text}." >> $log_main
fi

services=(php)
for service in "${services[@]}"; do
    log_file="/crons/$service/${periodicity}"
    mkdir -p log_file
    log_file="${log_file}/${value}.log"
    touch log_file
    url="http://${service}/cron/${periodicity}/$value"
    if [ "$debug" == true ]; then
        echo "${text} Service: ${service}. File: ${log_file}. URL: ${url}." >> $log_main
        curl -s $url >> $log_main
    else
        curl -s $url >> $log_file
    fi
done

