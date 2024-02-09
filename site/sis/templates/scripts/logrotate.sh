#!/bin/bash
/usr/sbin/logrotate -f -v /etc/logrotate.conf &>> /var/log/logrotate/rotate.log