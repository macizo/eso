#!/bin/bash

echo "Importing RPM-GPG-KEY-ORACLE-OL7"
rpm --import http://10.20.131.30/pub/keys/RPM-GPG-KEY-oracle-ol7
touch /opt/service/orcl_gpgkey_has_run
exit 0
