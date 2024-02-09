#/bin/bash
# CIS 9.1.12

echo `date +%d%b%Y` > /var/log/CIS/cis-9.1.12.log
cd /
/bin/df --local -P | /bin/awk {'if (NR!=1) print $6'} | /usr/bin/xargs -I '{}' /usr/bin/find '{}' -xdev -nogroup -ls  >> /var/log/CIS/cis-9.1.12.log
