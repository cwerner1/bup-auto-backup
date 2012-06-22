#!/bin/bash

BACKUP_DRIVE=/media/backup
mount() {
	mount ${BACKUP_DRIVE} -o remount,rw

}
unmount() {
        mount ${BACKUP_DRIVE} -o remount,ro
}

mount
echo "beginning backup: $(date)" >> ${BACKUP_DRIVE}/backupError.log


BUP_DIR=${BACKUP_DRIVE}/bup


bup index --exclude=~./gvfs/ --exclude=~/.cache/ ~ >> ${BACKUP_DRIVE}/backupError.log

echo ""
echo "beginning Saving: $(date)" >> ${BACKUP_DRIVE}/backupError.log

bup save -n $(hostname) ~ >> ${BACKUP_DRIVE}/backupError.log

unmount
echo "backup Done"
echo ""
