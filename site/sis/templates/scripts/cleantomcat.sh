#!/bin/bash
/bin/bash -c "nice -n 19 /bin/find /home/tomcat/Maildir/new -follow \( -name '*.test' \) -mtime +30 -exec /usr/bin/rm {} \;"