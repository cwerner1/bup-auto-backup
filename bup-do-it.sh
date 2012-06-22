#!/bin/bash

BACKUP_DRIVE=/media/backup
mount ${BACKUP_DRIVE} -o remount,rw

echo "beginning backup: $(date)" >> ${BACKUP_DRIVE}/backupError.log


BUP_DIR=${BACKUP_DRIVE}/bup


bup index --exclude=~./gvfs/ --exclude=~/.cache/ ~ >> ${BACKUP_DRIVE}/backupError.log

echo ""
echo "beginning Saving: $(date)" >> ${BACKUP_DRIVE}/backupError.log

bup save -n $(hostname) ~ >> ${BACKUP_DRIVE}/backupError.log

mount ${BACKUP_DRIVE} -o remount,ro

echo "backup Done"
echo ""
