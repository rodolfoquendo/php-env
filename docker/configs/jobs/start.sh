#!/bin/bash 

chmod -R 777 /scripts /crons
mkdir -p /crons /crons/main
touch /crons/main/start.log
echo "Cron starting" >> /crons/main/start.log
crontab -uroot /etc/crontab
crontab -l > /crons/main/crontab.txt
crond start
d=$(date)
who=$(whoami)
echo "Cron started: $d. $who" >> /crons/main/start.log
tail -f /crons/main/start.log