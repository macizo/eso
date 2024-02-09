#/bin/bash
# CIS 9.1.10

echo `date +%d%b%Y` > /var/log/CIS/cis-9.1.10.log
/bin/df --local -P | /bin/awk {'if (NR!=1) print $6'} | /usr/bin/xargs -I '{}' /usr/bin/find '{}' -xdev -type f -perm -0002 >> /var/log/CIS/cis-9.1.10.log
