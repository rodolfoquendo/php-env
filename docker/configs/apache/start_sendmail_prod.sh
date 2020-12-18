#!/bin/bash
d1=$(date)
# local
hostname_ip=$(echo "$(hostname -i)" | cut -d' ' -f 1)
# echo "$hostname_ip localhost" >> /etc/hosts

# echo "$hostname_ip insignia.local insignia.local.localhost" >> /etc/hosts
# echo "$hostname_ip school.insignia.local school.insignia.local.localhost" >> /etc/hosts
# echo "$hostname_ip files.insignia.local files.insignia.local.localhost" >> /etc/hosts
# echo "$hostname_ip mail.insignia.local mail.insignia.local.localhost" >> /etc/hosts
# echo "$hostname_ip push.insignia.local push.insignia.local.localhost" >> /etc/hosts

# # prod
# echo "$(hostname -i) insigniaeducation.com insigniaeducation.com.localhost" >> /etc/hosts
# echo "$(hostname -i) school.insigniaeducation.com school.insigniaeducation.com.localhost" >> /etc/hosts
# echo "$(hostname -i) files.insigniaeducation.com files.insigniaeducation.com.localhost" >> /etc/hosts
# echo "$(hostname -i) mail.insigniaeducation.com mail.insigniaeducation.com.localhost" >> /etc/hosts
# echo "$(hostname -i) push.insigniaeducation.com push.insigniaeducation.com.localhost" >> /etc/hosts
# echo "127.0.0.1 localhost localhost.localdomain insigniaeducation.com" >> /etc/hosts
echo "$hostname_ip localhost insigniaeducation.com" >> /etc/hosts
echo "$hostname_ip $hostname_ip $hostname_ip.localhost" >> /etc/hosts
echo "$hostname_ip $(hostname) $(hostname).localhost" >> /etc/hosts

echo "MASQUERADE_AS(insigniaeducation.com)dnl"  >> /etc/mail/sendmail.mc
echo "FEATURE(masquerade_envelope)dnl"  >> /etc/mail/sendmail.mc
echo "FEATURE(masquerade_entire_domain)dnl"  >> /etc/mail/sendmail.mc
echo "MASQUERADE_DOMAIN(insigniaeducation.com)dnl"  >> /etc/mail/sendmail.mc
echo "define(\`confCACERT_PATH\',\`/ssl_certs\')dnl"  >> /etc/mail/sendmail.mc
echo "define(\`confCACERT\',\`/ssl_certs/fullchain.crt\')dnl"  >> /etc/mail/sendmail.mc
echo "define(\`confSERVER_CERT\',\`/ssl_certs/cert.pem\')dnl"  >> /etc/mail/sendmail.mc
echo "define(\`confSERVER_KEY\',\`/ssl_certs/privkey.pem\')dnl"  >> /etc/mail/sendmail.mc

echo "insigniaeducation.com"  >> /etc/mail/local-host-names
echo "O HostsFile=/etc/hosts" >> /etc/mail/sendmail.cf
# echo "O CACertPath=/etc/hosts" >> /etc/mail/sendmail.cf

echo "ServerName localhost" >> /etc/apache2/apache2.conf

mkdir -p /logs
mkdir -p /logs/main
touch /logs/main/start.log

echo "Sendmail starting: $d." >> /logs/main/start.log
/etc/init.d/sendmail start
d=$(date)
echo "Sendmail iniciado: $d." >> /logs/main/start.log
echo "Iniciando Apache"
apachectl -DFOREGROUND
echo "Apache Iniciado"

