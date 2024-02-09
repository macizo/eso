#/bin/bash
# CIS 9.1.1

echo `date +%d%b%Y` > /var/log/CIS/cis-9.1.1.log
/usr/bin/rpm -Va --nomtime --nosize --nomd5 --nolinkto >> /var/log/CIS/cis-9.1.1.log
