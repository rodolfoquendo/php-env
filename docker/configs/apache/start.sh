#!/bin/bash
d1=$(date)
echo "127.0.0.1 insignia.local localhost insigniaeducation.com insigniaeducation.com insigniaeducation.com.localhost" >> /etc/hosts
echo "ServerName localhost" >> /etc/apache2/apache2.conf
d=$(date)
echo "Apache started: $d"
apachectl -DFOREGROUND
