#/bin/bash
# CIS 9.1.11

echo `date +%d%b%Y` > /var/log/CIS/cis-9.1.11.log
cd / && /usr/bin/df --local -P | /usr/bin/awk {'if (NR!=1) print $6'} | /usr/bin/xargs -I '{}' /usr/bin/find '{}' -xdev -nouser -ls >> /var/log/CIS/cis-9.1.11.log
