#!/bin/bash

# If there is no R5 to test, use BE2
R5_HOST=10.20.140.7

# We use SSH keys to authenticate, so password is not required
R5_USER=bastian

# This is also used at line 66 - unable to use this variable in that command
BACKUP_PATH=/opt/service/backup/masterFileshare/DO-NOT-EDIT

MASTERFILESHARE_PATH=/opt/service/masterFileshare
ZIP=masterFileshare.zip

LOG_FILE=/opt/service/logs/maintenance/backup-masterFileshare.log

clear
echo "$(date)" | sudo tee -a $LOG_FILE
echo "$(date) Running script to backup masterFileshare" | sudo tee -a $LOG_FILE

[[ -d $BACKUP_PATH ]] | mkdir -p $BACKUP_PATH

cd $BACKUP_PATH

# If this file exists (created in the else below),
# then previous run was not successful, so skip backing up again
if [[ -f $BACKUP_PATH/allfiles.zip ]]; then
        echo "$(date) ERROR - Something went wrong with the previous run" | sudo tee -a $LOG_FILE
        echo "$(date) Restoring the backup to last good known backups and will do the transfer of these to R5" | sudo tee -a $LOG_FILE
        rm -f masterFileshare.zip.*
        unzip allfiles.zip
else
        echo "$(date) Backing up masterFileshare" | sudo tee -a $LOG_FILE

        backupcount=$(find $BACKUP_PATH -type f -name "masterFileshare.zip*" | wc -l)

        # Zipping all existing backup files to verify whether the previous run was OK
        if [[ $backupcount > 0 ]]; then
                zip allfiles.zip masterFileshare.zip.*
        fi

        if [[ $backupcount = 5 ]]; then
                rm -f masterFileshare.zip.5
                backupcount=$((backupcount-1))
        fi

        if [[ $backupcount > 0 ]]; then
                i=$backupcount
                while [[ $i -gt 0 ]]; do
                        mv $ZIP.$i $ZIP.$((i+1))
                        i=$((i-1))
                done
        fi

        cp -r $MASTERFILESHARE_PATH .
        zip -r $ZIP.1 masterFileshare
        rm -rf masterFileshare

        echo "$(date) masterFileshare backup is created" | sudo tee -a $LOG_FILE
fi

# copy to R5
echo "$(date) Creating backup folder path in R5 if it does not exist" | sudo tee -a $LOG_FILE
ssh $R5_HOST 'mkdir -p /opt/service/backup/masterFileshare/DO-NOT-EDIT'

echo "$(date) Copying the backup files to R5" | sudo tee -a $LOG_FILE
scp -r -q masterFileshare.zip.* $R5_USER@$R5_HOST:$BACKUP_PATH

# Everything is OK, so delete allfiles.zip
rm -f allfiles.zip

echo "$(date) Done!" | sudo tee -a $LOG_FILE
