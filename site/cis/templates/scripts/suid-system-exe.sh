#/bin/bash
# CIS 9.1.13

echo `date +%d%b%Y` > /var/log/CIS/cis-9.1.13.log
cd  / && df --local -P | awk {'if (NR!=1) print $6'} | /usr/bin/xargs -I '{}' /usr/bin/find '{}' -xdev -type f -perm -4000 -print  >> /var/log/CIS/cis-9.1.13.log
