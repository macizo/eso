#/bin/bash
# CIS 1.2.6

echo `date +%d%b%Y` > /var/log/CIS/cis-1.2.6.log
rpm -qVa | awk '$2 != "c" { print $0}' >> /var/log/CIS/cis-1.2.6.log
