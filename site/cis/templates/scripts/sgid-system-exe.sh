#/bin/bash
# CIS 9.1.14

echo `date +%d%b%Y` > /var/log/CIS/cis-9.1.14.log
cd  / && df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -2000 -print  >> /var/log/CIS/cis-9.1.14.log
