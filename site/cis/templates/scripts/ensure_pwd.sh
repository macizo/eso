#/bin/bash
# CIS 9.2.1

echo `date +%d%b%Y` > /var/log/CIS/cis-9.2.1.log
echo "Users with no password set. Investigate." >> /var/log/CIS/cis-9.2.1.log
/bin/awk -F: '($2 == "" ) { print $1 " does not have a password "}'  /etc/shadow >> /var/log/CIS/cis-9.2.1.log
