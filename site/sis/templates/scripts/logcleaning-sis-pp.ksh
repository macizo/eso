#!/bin/ksh
###################################################
# Written By: vfrem
# Purpose: Compress recent logs, and clean out old log files,
# Created: November 19th 2012
# Edited: March 22nd  2016 prboh
# Version: 0.95
###################################################

# Variables #
COMPRESS=0
DELETE=0
SERVICEDIR=/opt/service/logs
LOGFILE=$SERVICEDIR/maintenance/logcleaning-$(date -u +'%Y-%B').log
LOGPATTERN=*log.*

usage(){
        echo "usage= $0 [-c] [-d] [-s]
        eg:
        $0 -c -d -s
        -c Compress log files that are $COMPRESSDAYS days or older
        -d Delete log files older than $DELETEDays days
        "
        exit 1
}
logInfo(){
        echo "$(date -u +'%Y-%m-%d %H:%M:%S') [INFO] $1" >> $LOGFILE
}
logError(){
        echo "$(date -u +'%Y-%m-%d %H:%M:%S') [ERROR] $1" >> $LOGFILE
}


compressLogs(){
        for f in $(/bin/find $LOGFOLDER/ -name "$LOGPATTERN" -mtime +$COMPRESSDAYS|grep -v "gz");
        do
                gzip $f || logError "Could not compress $f"

                # Do not move files after gzip this time
                #mv $f.gz $ARCHIVEFOLDER/${f##*/}.gz || echo "ERROR during logrotate using $0: Could move $f.gz" >> $LOGFILE;
        done
}
deleteOldLogs(){
        for f in $(/bin/find $LOGFOLDER/ -name "$LOGPATTERN" -mtime +$DELETEDAYS);
        do
                rm -f $f || logError "Could not delete $f"
        done
}

if [[ -z $1 ]];
then
        print 'please provide an input parameter'
        usage
fi

#-------------GET INPUT PARAMETERS---------------------
while getopts "cd" options; do
  case $options in
    c   )
                        COMPRESS=1
        ;;
    d   )
                        DELETE=1
        ;;
    \?  ) print 'invalid option provided'
                usage
        ;;
    h|* ) usage
        ;;
  esac
done
shift $(($OPTIND - 1))

if [[ -n $1 ]];
then
        print 'You have provided more options than you should'
        usage
fi
logInfo "Starting LogCleaning"

# Clean maintenance folder
LOGFOLDER=$SERVICEDIR/maintenance
COMPRESSDAYS=3
DELETEDAYS=10
[[ $COMPRESS -eq 1 ]] && compressLogs
[[ $DELETE -eq 1 ]] && deleteOldLogs

# Clean archive folder
LOGFOLDER=$SERVICEDIR/archive
COMPRESSDAYS=2
DELETEDAYS=365
[[ $COMPRESS -eq 1 ]] && compressLogs
[[ $DELETE -eq 1 ]] && deleteOldLogs


logInfo "End LogCleaning"
exit
