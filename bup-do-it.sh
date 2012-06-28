#!/bin/bash
BACKUP_DRIVE=/media/backup
BUP_DIR=${BACKUP_DRIVE}/bup

mountit() {
	mount ${BACKUP_DRIVE} -o remount,rw

}
unmountit() {
        mount ${BACKUP_DRIVE} -o remount,ro
}

mountit
echo "beginning backup: $(date)" >> ${BACKUP_DRIVE}/backupError.log




bup index --exclude=~./gvfs/ --exclude=~/.cache/ ~ >> ${BACKUP_DRIVE}/backupError.log

echo ""
echo "beginning Saving: $(date)" >> ${BACKUP_DRIVE}/backupError.log

bup save -n $(hostname) ~ >> ${BACKUP_DRIVE}/backupError.log

unmountit
echo "backup Done"
echo ""
